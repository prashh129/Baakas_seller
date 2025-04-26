import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../features/shop/controllers/notification_controller.dart';
import '../../../features/communication/screens/chat_screen.dart';

class NotificationList extends StatelessWidget {
  final String type;

  const NotificationList({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();

    return Obx(() {
      final notifications = _getNotificationsByType(controller);

      if (notifications.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getIconForType(type),
                size: 64,
                color: Theme.of(
                  context,
                ).textTheme.bodyLarge?.color?.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No Notifications',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.color?.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _getEmptyMessageForType(type),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.color?.withOpacity(0.5),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationTile(
            title: notification.title,
            description: notification.message,
            time: _formatTimeAgo(notification.timestamp),
            icon: _getIconForType(type),
            color: _getColorForType(type, context),
            orderId: notification.id,
            isRead: notification.isRead,
            onTap: () {
              controller.markAsRead(notification.id);
              if (type == 'chat') {
                Get.to(() => ChatScreen(
                  userId: notification.id,
                  userName: notification.title,
                ));
              }
            },
          );
        },
      );
    });
  }

  List<NotificationModel> _getNotificationsByType(
    NotificationController controller,
  ) {
    switch (type) {
      case 'order':
        return controller.orderNotifications;
      case 'chat':
        return controller.messageNotifications;
      default:
        return controller.notifications;
    }
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'order':
        return Iconsax.shopping_cart;
      case 'chat':
        return Iconsax.message;
      default:
        return Iconsax.notification;
    }
  }

  Color _getColorForType(String type, BuildContext context) {
    switch (type) {
      case 'order':
        return Theme.of(context).colorScheme.primary;
      case 'chat':
        return Theme.of(context).colorScheme.tertiary;
      default:
        return Theme.of(context).textTheme.bodyLarge?.color ?? Colors.grey;
    }
  }

  String _getEmptyMessageForType(String type) {
    switch (type) {
      case 'order':
        return 'No order notifications yet';
      case 'chat':
        return 'No new messages';
      default:
        return 'No notifications';
    }
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color color;
  final String orderId;
  final bool isRead;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.color,
    required this.orderId,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.bodyLarge?.color?.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.bodyLarge?.color?.withOpacity(0.5),
              ),
            ),
          ],
        ),
        trailing:
            !isRead
                ? Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                )
                : null,
        onTap: onTap,
      ),
    );
  }
}
