import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:baakas_seller/utils/constants/sizes.dart';
import '../../../utils/constants/colors.dart';

class MessageTemplates extends StatelessWidget {
  const MessageTemplates({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> templates = {
      'Order Confirmation':
          'Thank you for your order! Your order #[ORDER_ID] has been confirmed and is being processed.',
      'Shipping Update':
          'Your order #[ORDER_ID] has been shipped and is on its way to you. Tracking number: [TRACKING_ID]',
      'Delivery Confirmation':
          'Great news! Your order #[ORDER_ID] has been delivered. Thank you for shopping with us!',
      'Payment Reminder':
          'This is a friendly reminder that payment for order #[ORDER_ID] is pending. Please complete the payment to avoid delays.',
      'New Product Launch':
          'Exciting news! We\'ve just launched [PRODUCT_NAME]. Check it out now!',
      'Special Discount':
          'Special offer just for you! Get [DISCOUNT]% off on your next purchase. Use code: [CODE]',
      'Festival Sale':
          'Celebrate with us! Get amazing deals during our Festival Sale. Up to [DISCOUNT]% off!',
      'Customer Feedback Request':
          'We value your opinion! Please share your feedback about your recent purchase.',
    };

    return Padding(
      padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MessageSection(
              title: 'Quick Messages',
              icon: Iconsax.message_programming,
              color: BaakasColors.primaryColor,
              items: const [
                'Order Confirmation',
                'Shipping Update',
                'Delivery Confirmation',
                'Payment Reminder',
              ],
              templates: templates,
            ),
            const SizedBox(height: BaakasSizes.spaceBtwSections),
            MessageSection(
              title: 'Promotional Messages',
              icon: Iconsax.message_favorite,
              color: BaakasColors.primaryColor,
              items: const [
                'New Product Launch',
                'Special Discount',
                'Festival Sale',
                'Customer Feedback Request',
              ],
              templates: templates,
            ),
          ],
        ),
      ),
    );
  }
}

class MessageSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> items;
  final Map<String, String> templates;

  const MessageSection({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
    required this.templates,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: BaakasSizes.spaceBtwItems),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: BaakasSizes.spaceBtwItems),
        ...items
            .map(
              (item) => MessageTemplateCard(
                title: item,
                template: templates[item] ?? '',
              ),
            )
            ,
      ],
    );
  }
}

class MessageTemplateCard extends StatefulWidget {
  final String title;
  final String template;

  const MessageTemplateCard({super.key, required this.title, required this.template});

  @override
  State<MessageTemplateCard> createState() => _MessageTemplateCardState();
}

class _MessageTemplateCardState extends State<MessageTemplateCard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _currentUserId = FirebaseAuth.instance.currentUser?.uid;

  Future<void> _showSendDialog(BuildContext context, bool isSMS) async {
    final theme = Theme.of(context);
    final TextEditingController customerIdController = TextEditingController();
    final TextEditingController messageController = TextEditingController(
      text: widget.template,
    );

    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        title: Text(
          'Send ${isSMS ? 'SMS' : 'Email'}',
          style: theme.textTheme.titleLarge,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: customerIdController,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration(
                labelText: 'Customer ID/Name',
                labelStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: theme.dividerColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: theme.colorScheme.primary),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: messageController,
              style: theme.textTheme.bodyMedium,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Message',
                labelStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: theme.dividerColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: theme.colorScheme.primary),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: TextStyle(color: theme.colorScheme.primary),
            ),
          ),
          TextButton(
            onPressed: () {
              if (_currentUserId == null || customerIdController.text.isEmpty) {
                return;
              }

              final chatId = 'chat_${_currentUserId}_${customerIdController.text.replaceAll(' ', '_')}';

              _firestore
                  .collection('Sellers')
                  .doc(_currentUserId)
                  .collection('chats')
                  .doc(chatId)
                  .collection('messages')
                  .add({
                    'senderId': _currentUserId,
                    'senderName': 'Seller',
                    'message': messageController.text,
                    'timestamp': FieldValue.serverTimestamp(),
                  })
                  .then((_) => _firestore
                      .collection('Sellers')
                      .doc(_currentUserId)
                      .collection('chats')
                      .doc(chatId)
                      .set({
                        'lastMessage': messageController.text,
                        'lastMessageTime': FieldValue.serverTimestamp(),
                        'customerName': customerIdController.text,
                        'customerId': customerIdController.text.replaceAll(' ', '_').toLowerCase(),
                        'unread': false,
                      }, SetOptions(merge: true)))
                  .then((_) {
                    if (dialogContext.mounted) {
                      Navigator.pop(dialogContext);
                    }
                  })
                  .catchError((e) {
                    if (dialogContext.mounted) {
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        SnackBar(content: Text('Error sending message: $e')),
                      );
                    }
                  });
            },
            child: Text(
              'Send',
              style: TextStyle(color: theme.colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(widget.title, style: theme.textTheme.titleSmall),
        subtitle: Text(
          widget.template,
          style: theme.textTheme.bodyMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Iconsax.sms, color: theme.colorScheme.primary),
              onPressed: () => _showSendDialog(context, true),
            ),
            IconButton(
              icon: Icon(Iconsax.direct, color: theme.colorScheme.primary),
              onPressed: () => _showSendDialog(context, false),
            ),
          ],
        ),
      ),
    );
  }
}
