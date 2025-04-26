import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import 'message_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.chatName,
    this.isAdminChat = false,
  });

  final String chatName;
  final bool isAdminChat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaakasAppBar(
        showBackArrow: true,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color:
                    isAdminChat
                        ? BaakasColors.primaryColor
                        : BaakasColors.grey.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isAdminChat ? Iconsax.support : Iconsax.user,
                color: isAdminChat ? BaakasColors.white : BaakasColors.dark,
                size: 20,
              ),
            ),
            const SizedBox(width: BaakasSizes.sm),
            Text(chatName, style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        actions: [
          if (!isAdminChat)
            PopupMenuButton(
              icon: const Icon(Iconsax.more),
              itemBuilder:
                  (context) => [
                    const PopupMenuItem(
                      value: 'block',
                      child: Row(
                        children: [
                          Icon(Iconsax.user_minus, size: 18),
                          SizedBox(width: BaakasSizes.sm),
                          Text('Block User'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'report',
                      child: Row(
                        children: [
                          Icon(Iconsax.flag, size: 18),
                          SizedBox(width: BaakasSizes.sm),
                          Text('Report User'),
                        ],
                      ),
                    ),
                  ],
              onSelected: (value) {
                // Handle block/report actions
                if (value == 'block') {
                  // Show block confirmation dialog
                } else if (value == 'report') {
                  // Show report dialog
                }
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
              reverse: true,
              itemCount: 10, // Replace with actual message count
              itemBuilder: (context, index) {
                final isMe = index % 2 == 0;
                return MessageBubble(
                  message: 'This is a sample message #$index',
                  time: '2:30 PM',
                  isMe: isMe,
                );
              },
            ),
          ),

          // Message Input
          Container(
            padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                top: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          BaakasSizes.inputFieldRadius,
                        ),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: BaakasSizes.md,
                        vertical: BaakasSizes.sm,
                      ),
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(width: BaakasSizes.sm),
                Container(
                  decoration: const BoxDecoration(
                    color: BaakasColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Send message
                    },
                    icon: const Icon(Iconsax.send1, color: BaakasColors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
