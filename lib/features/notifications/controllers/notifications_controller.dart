import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum NotificationType { order, stock, message }

class Notification {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationType type;
  final bool isRead;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });
}

class NotificationsController extends GetxController {
  static NotificationsController get instance => Get.find();

  final RxList<Notification> notifications = <Notification>[].obs;
  final RxInt unreadCount = 0.obs;
  final String? _currentUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    if (_currentUserId == null) return;

    FirebaseFirestore.instance
        .collection('Sellers')
        .doc(_currentUserId)
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
          notifications.value = snapshot.docs.map((doc) {
            final data = doc.data();
            return Notification(
              id: doc.id,
              title: data['title'] ?? '',
              message: data['message'] ?? '',
              timestamp: (data['timestamp'] as Timestamp).toDate(),
              type: _getNotificationType(data['type'] ?? 'order'),
              isRead: data['isRead'] ?? false,
            );
          }).toList();
          updateUnreadCount();
        });
  }

  NotificationType _getNotificationType(String type) {
    switch (type) {
      case 'order':
        return NotificationType.order;
      case 'stock':
        return NotificationType.stock;
      case 'message':
        return NotificationType.message;
      default:
        return NotificationType.order;
    }
  }

  void markAsRead(String id) {
    if (_currentUserId == null) return;

    FirebaseFirestore.instance
        .collection('Sellers')
        .doc(_currentUserId)
        .collection('notifications')
        .doc(id)
        .update({'isRead': true})
        .then((_) {
          final index = notifications.indexWhere((n) => n.id == id);
          if (index != -1) {
            final notification = notifications[index];
            notifications[index] = Notification(
              id: notification.id,
              title: notification.title,
              message: notification.message,
              timestamp: notification.timestamp,
              type: notification.type,
              isRead: true,
            );
            updateUnreadCount();
          }
        });
  }

  void updateUnreadCount() {
    unreadCount.value = notifications.where((n) => !n.isRead).length;
  }
}
