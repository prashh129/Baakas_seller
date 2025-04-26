import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../controllers/support_controller.dart';
import '../../../utils/constants/colors.dart';

class SupportTicketList extends StatelessWidget {
  const SupportTicketList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SupportController>();
    final theme = Theme.of(context);

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.tickets.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.message,
                size: 64,
                color: theme.colorScheme.onSurface.withOpacity(0.4),
              ),
              const SizedBox(height: 16),
              Text(
                'No Support Tickets',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.4),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Create a new ticket for support',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.4),
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.tickets.length,
        itemBuilder: (context, index) {
          final ticket = controller.tickets[index];
          return Card(
            color: theme.colorScheme.surface,
            child: ListTile(
              title: Text(
                ticket.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(
                            ticket.status,
                          ).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          ticket.status.toString().split('.').last,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: _getStatusColor(ticket.status),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${ticket.messages.length} messages',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Text(
                _formatDate(ticket.createdAt),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.4),
                ),
              ),
              onTap: () {
                // TODO: Navigate to ticket detail screen
              },
            ),
          );
        },
      );
    });
  }

  Color _getStatusColor(SupportTicketStatus status) {
    switch (status) {
      case SupportTicketStatus.open:
        return BaakasColors.primaryColor;
      case SupportTicketStatus.inProgress:
        return Colors.orange;
      case SupportTicketStatus.resolved:
        return Colors.blue;
      case SupportTicketStatus.closed:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
