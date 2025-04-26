import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();
  final _logger = Logger();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _currentUserId = FirebaseAuth.instance.currentUser?.uid;

  final RxInt _notificationCount = 0.obs;
  final RxList<NotificationModel> _notifications = <NotificationModel>[].obs;
  final RxList<NotificationModel> _orderNotifications =
      <NotificationModel>[].obs;
  final RxList<NotificationModel> _stockNotifications =
      <NotificationModel>[].obs;
  final RxList<NotificationModel> _messageNotifications =
      <NotificationModel>[].obs;

  int get notificationCount => _notificationCount.value;
  List<NotificationModel> get notifications => _notifications;
  List<NotificationModel> get orderNotifications => _orderNotifications;
  List<NotificationModel> get stockNotifications => _stockNotifications;
  List<NotificationModel> get messageNotifications => _messageNotifications;

  @override
  void onInit() {
    super.onInit();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    if (_currentUserId == null) return;

    try {
      _firestore
          .collection('Sellers')
          .doc(_currentUserId)
          .collection('notifications')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .listen((snapshot) {
            _notifications.value =
                snapshot.docs.map((doc) {
                  final data = doc.data();
                  return NotificationModel(
                    id: doc.id,
                    title: data['title'] ?? '',
                    message: data['message'] ?? '',
                    timestamp: (data['timestamp'] as Timestamp).toDate(),
                    type: data['type'] ?? 'order',
                    isRead: data['isRead'] ?? false,
                    imageUrl: data['imageUrl'],
                  );
                }).toList();

            // Filter notifications by type
            _orderNotifications.value =
                _notifications.where((n) => n.type == 'order').toList();
            _stockNotifications.value =
                _notifications.where((n) => n.type == 'stock').toList();
            _messageNotifications.value =
                _notifications.where((n) => n.type == 'message').toList();

            _updateNotificationCount();
          });
    } catch (e) {
      _logger.e('Error loading notifications: $e');
    }
  }

  Future<void> markAsRead(String id) async {
    if (_currentUserId == null) return;

    try {
      await _firestore
          .collection('Sellers')
          .doc(_currentUserId)
          .collection('notifications')
          .doc(id)
          .update({'isRead': true});

      _updateNotificationCount();
    } catch (e) {
      _logger.e('Error marking notification as read: $e');
    }
  }

  Future<void> markAllAsRead() async {
    if (_currentUserId == null) return;

    try {
      final batch = _firestore.batch();
      final notifications =
          await _firestore
              .collection('Sellers')
              .doc(_currentUserId)
              .collection('notifications')
              .where('isRead', isEqualTo: false)
              .get();

      for (var doc in notifications.docs) {
        batch.update(doc.reference, {'isRead': true});
      }

      await batch.commit();
      _updateNotificationCount();
    } catch (e) {
      _logger.e('Error marking all notifications as read: $e');
    }
  }

  Future<void> clearAllNotifications() async {
    if (_currentUserId == null) return;

    try {
      final batch = _firestore.batch();
      final notifications =
          await _firestore
              .collection('Sellers')
              .doc(_currentUserId)
              .collection('notifications')
              .get();

      for (var doc in notifications.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      _notifications.clear();
      _orderNotifications.clear();
      _stockNotifications.clear();
      _messageNotifications.clear();
      _notificationCount.value = 0;
    } catch (e) {
      _logger.e('Error clearing notifications: $e');
    }
  }

  void _updateNotificationCount() {
    _notificationCount.value = _notifications.where((n) => !n.isRead).length;
  }

  // Helper methods to create notifications
  Future<void> createOrderNotification({
    required String orderId,
    required String title,
    required String message,
  }) async {
    await _createNotification(
      title: title,
      message: message,
      type: 'order',
      data: {'orderId': orderId},
    );
  }

  Future<void> createStockNotification({
    required String productId,
    required String title,
    required String message,
  }) async {
    await _createNotification(
      title: title,
      message: message,
      type: 'stock',
      data: {'productId': productId},
    );
  }

  Future<void> createMessageNotification({
    required String senderId,
    required String title,
    required String message,
  }) async {
    await _createNotification(
      title: title,
      message: message,
      type: 'message',
      data: {'senderId': senderId},
    );
  }

  Future<void> _createNotification({
    required String title,
    required String message,
    required String type,
    Map<String, dynamic>? data,
  }) async {
    if (_currentUserId == null) return;

    try {
      await _firestore
          .collection('Sellers')
          .doc(_currentUserId)
          .collection('notifications')
          .add({
            'title': title,
            'message': message,
            'type': type,
            'timestamp': FieldValue.serverTimestamp(),
            'isRead': false,
            if (data != null) ...data,
          });
    } catch (e) {
      _logger.e('Error creating notification: $e');
    }
  }
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final String type;
  final String? imageUrl;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    this.imageUrl,
    this.isRead = false,
  });
}
