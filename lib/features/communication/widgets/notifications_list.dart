import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../features/shop/controllers/notification_controller.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

    return Obx(() {
      if (controller.notifications.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.notification,
                size: 64,
                color: Theme.of(
                  context,
                ).textTheme.bodyLarge?.color?.withValues(alpha: 128),
              ),
              const SizedBox(height: 16),
              Text(
                'No Notifications',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.color?.withValues(alpha: 128),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You will see your notifications here',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.color?.withValues(alpha: 128),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.notifications.length,
        itemBuilder: (context, index) {
          final notification = controller.notifications[index];
          return NotificationTile(
            title: notification.title,
            description: notification.message,
            time: _formatTimeAgo(notification.timestamp),
            icon: _getIconForType(notification.type),
            color: _getColorForType(notification.type, context),
            orderId: notification.id,
            isRead: notification.isRead,
            onTap: () => controller.markAsRead(notification.id),
          );
        },
      );
    });
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

  IconData _getIconForType(String type) {
    switch (type) {
      case 'order':
        return Iconsax.shopping_cart;
      case 'stock':
        return Iconsax.box;
      case 'message':
        return Iconsax.message;
      default:
        return Iconsax.notification;
    }
  }

  Color _getColorForType(String type, BuildContext context) {
    switch (type) {
      case 'order':
        return Theme.of(context).colorScheme.primary;
      case 'stock':
        return Theme.of(context).colorScheme.secondary;
      case 'message':
        return Theme.of(context).colorScheme.tertiary;
      default:
        return Theme.of(context).textTheme.bodyLarge?.color ?? Colors.grey;
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
            color: color.withValues(alpha: 51),
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
                ).textTheme.bodyLarge?.color?.withValues(alpha: 128),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.bodyLarge?.color?.withValues(alpha: 128),
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
