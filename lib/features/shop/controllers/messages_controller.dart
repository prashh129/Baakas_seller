import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../data/repositories/message_repository.dart';
import '../models/chat.dart';
import '../models/message.dart';

class MessagesController extends GetxController {
  static MessagesController get instance => Get.find();
  final _logger = Logger();

  final _messageRepo = MessageRepository.instance;
  final chats = <Chat>[].obs;
  final messages = <Message>[].obs;
  final isLoading = false.obs;
  final hasUnreadMessages = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadChats();
  }

  Future<void> loadChats() async {
    try {
      isLoading.value = true;
      final chatList = await _messageRepo.getChats();
      chats.assignAll(chatList);
      checkUnreadMessages();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load chats: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMessages(String chatId) async {
    try {
      isLoading.value = true;
      final messageList = await _messageRepo.getMessages(chatId);
      messages.assignAll(messageList);
      markMessagesAsRead(chatId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load messages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage(String chatId, String content) async {
    try {
      await _messageRepo.sendMessage(chatId, content);
      await loadMessages(chatId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to send message: $e');
    }
  }

  Future<void> markMessagesAsRead(String chatId) async {
    try {
      await _messageRepo.markMessagesAsRead(chatId);
      checkUnreadMessages();
    } catch (e) {
      _logger.e('Error marking messages as read: $e');
    }
  }

  void checkUnreadMessages() {
    hasUnreadMessages.value = chats.any(
      (chat) => chat.getUnreadCount(chat.getOtherParticipantId('')) > 0,
    );
  }

  Future<void> blockUser(String userId) async {
    try {
      await _messageRepo.blockUser(userId);
      Get.snackbar('Success', 'User has been blocked');
      loadChats(); // Refresh chat list
    } catch (e) {
      Get.snackbar('Error', 'Failed to block user: $e');
    }
  }

  Future<void> reportUser(String userId, String reason) async {
    try {
      await _messageRepo.reportUser(userId, reason);
      Get.snackbar('Success', 'User has been reported');
    } catch (e) {
      Get.snackbar('Error', 'Failed to report user: $e');
    }
  }
}
