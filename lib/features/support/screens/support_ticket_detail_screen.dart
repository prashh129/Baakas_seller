import 'package:flutter/material.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../utils/constants/colors.dart';

class SupportTicketDetailScreen extends StatelessWidget {
  const SupportTicketDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const BaakasAppBar(
        showBackArrow: true,
        title: Text('Ticket Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ticket #12345',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Subject: Order not received',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 128),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Status: Open',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: BaakasColors.primaryColor,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Description',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'I haven\'t received my order #12345 that was supposed to be delivered yesterday.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 128),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Messages',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              // Message list would go here
            ],
          ),
        ),
      ),
    );
  }
} 