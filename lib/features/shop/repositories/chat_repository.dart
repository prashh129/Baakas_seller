import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat.dart';
import '../models/message.dart';

class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all chats for a user
  Stream<List<Chat>> getUserChats(String userId) {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            // Find the other participant's data
            final otherParticipantId = (data['participants'] as List)
                .firstWhere((id) => id != userId);
            return Chat.fromJson({
              'id': doc.id,
              ...data,
              'participantId': otherParticipantId,
            });
          }).toList();
        });
  }

  // Get messages for a specific chat
  Stream<List<Message>> getChatMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Message.fromJson({'id': doc.id, ...doc.data()}))
              .toList();
        });
  }

  // Send a new message
  Future<void> sendMessage(Message message) async {
    await _firestore
        .collection('chats')
        .doc(message.chatId)
        .collection('messages')
        .add(message.toJson());

    // Update the last message in the chat
    await _firestore.collection('chats').doc(message.chatId).update({
      'lastMessage': message.content,
      'lastMessageTime': message.timestamp.toIso8601String(),
    });
  }

  // Mark messages as read
  Future<void> markMessagesAsRead(String chatId, String userId) async {
    final messagesQuery =
        await _firestore
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .where('receiverId', isEqualTo: userId)
            .where('isRead', isEqualTo: false)
            .get();

    final batch = _firestore.batch();
    for (var doc in messagesQuery.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }

  // Create or get existing chat
  Future<String> createOrGetChat(String userId1, String userId2) async {
    final chatQuery =
        await _firestore
            .collection('chats')
            .where('participants', arrayContains: userId1)
            .get();

    for (var doc in chatQuery.docs) {
      final participants = List<String>.from(doc.data()['participants']);
      if (participants.contains(userId2)) {
        return doc.id;
      }
    }

    // Create new chat if none exists
    final newChatRef = await _firestore.collection('chats').add({
      'participants': [userId1, userId2],
      'lastMessage': '',
      'lastMessageTime': DateTime.now().toIso8601String(),
      'createdAt': DateTime.now().toIso8601String(),
    });

    return newChatRef.id;
  }

  // Block/Unblock user
  Future<void> updateBlockStatus(String chatId, bool isBlocked) async {
    await _firestore.collection('chats').doc(chatId).update({
      'isBlocked': isBlocked,
    });
  }
}
