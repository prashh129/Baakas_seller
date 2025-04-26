import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final String userId;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  final messageController = TextEditingController();
  final messages = <ChatMessage>[].obs;

  ChatController({required this.userId});

  @override
  void onInit() {
    super.onInit();
    _loadMessages();
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void _loadMessages() {
    if (currentUserId == null) return;

    FirebaseFirestore.instance
        .collection('chats')
        .doc(_getChatId())
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      messages.value = snapshot.docs
          .map((doc) => ChatMessage.fromFirestore(doc))
          .toList();
    });
  }

  String _getChatId() {
    // Create a unique chat ID by combining user IDs in alphabetical order
    final ids = [currentUserId!, userId]..sort();
    return '${ids[0]}_${ids[1]}';
  }

  Future<void> sendMessage() async {
    if (currentUserId == null) return;
    if (messageController.text.trim().isEmpty) return;

    try {
      final chatId = _getChatId();
      final message = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: messageController.text.trim(),
        senderId: currentUserId!,
        timestamp: DateTime.now(),
      );

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(message.id)
          .set(message.toMap());

      messageController.clear();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send message',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

class ChatMessage {
  final String id;
  final String text;
  final String senderId;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.senderId,
    required this.timestamp,
  });

  factory ChatMessage.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatMessage(
      id: doc.id,
      text: data['text'] ?? '',
      senderId: data['senderId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'senderId': senderId,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
} 