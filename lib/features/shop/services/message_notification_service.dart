import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/messages/conversations_screen.dart';
import '../controllers/messages_controller.dart';

class MessageNotificationService {
  static Future<void> initialize() async {
    // Initialize MessagesController
    Get.put(MessagesController());

    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'messages_channel',
        channelName: 'Messages',
        channelDescription: 'Notifications for new messages',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: const Color(0xFF9D50DD),
        importance: NotificationImportance.High,
      ),
    ]);

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: (ReceivedAction receivedAction) async {
        Get.to(() => const ConversationsScreen(currentUserId: ''));
      },
    );
  }

  static Future<void> showMessageNotification({
    required String title,
    required String body,
    required String senderId,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: senderId.hashCode,
        channelKey: 'messages_channel',
        title: title,
        body: body,
        payload: {'senderId': senderId},
      ),
    );
  }
}
