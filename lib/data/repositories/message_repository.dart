import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/shop/models/chat.dart';
import '../../features/shop/models/message.dart';
import '../../features/shop/repositories/chat_repository.dart';

class MessageRepository {
  static final MessageRepository instance = MessageRepository._();
  MessageRepository._();

  final ChatRepository _chatRepo = ChatRepository();

  Future<List<Chat>> getChats() async {
    final userId =
        FirebaseFirestore.instance
            .collection('users')
            .doc()
            .id; // Replace with actual user ID
    final chats = await _chatRepo.getUserChats(userId).first;
    return chats;
  }

  Future<List<Message>> getMessages(String chatId) async {
    final messages = await _chatRepo.getChatMessages(chatId).first;
    return messages;
  }

  Future<void> sendMessage(String chatId, String content) async {
    final message = Message(
      id: DateTime.now().toString(),
      chatId: chatId,
      senderId:
          FirebaseFirestore.instance
              .collection('users')
              .doc()
              .id, // Replace with actual user ID
      receiverId: '', // Set this based on chat participants
      content: content,
      timestamp: DateTime.now(),
    );
    await _chatRepo.sendMessage(message);
  }

  Future<void> markMessagesAsRead(String chatId) async {
    final userId =
        FirebaseFirestore.instance
            .collection('users')
            .doc()
            .id; // Replace with actual user ID
    await _chatRepo.markMessagesAsRead(chatId, userId);
  }

  Future<void> blockUser(String userId) async {
    // Implement blocking logic using ChatRepository
    final chatId = await _chatRepo.createOrGetChat(
      FirebaseFirestore.instance
          .collection('users')
          .doc()
          .id, // Replace with actual user ID
      userId,
    );
    await _chatRepo.updateBlockStatus(chatId, true);
  }

  Future<void> reportUser(String userId, String reason) async {
    // Implement report logic
    await FirebaseFirestore.instance.collection('reports').add({
      'reportedUserId': userId,
      'reason': reason,
      'timestamp': DateTime.now(),
      'reporterId':
          FirebaseFirestore.instance
              .collection('users')
              .doc()
              .id, // Replace with actual user ID
    });
  }
}
