import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isMe,
  });

  final String message;
  final String time;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BaakasSizes.sm),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) const SizedBox(width: BaakasSizes.lg),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: BaakasSizes.md,
                vertical: BaakasSizes.sm,
              ),
              decoration: BoxDecoration(
                color:
                    isMe
                        ? BaakasColors.primaryColor
                        : Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(BaakasSizes.cardRadiusLg),
                  topRight: const Radius.circular(BaakasSizes.cardRadiusLg),
                  bottomLeft: Radius.circular(
                    isMe ? BaakasSizes.cardRadiusLg : 0,
                  ),
                  bottomRight: Radius.circular(
                    isMe ? 0 : BaakasSizes.cardRadiusLg,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isMe ? BaakasColors.white : null,
                    ),
                  ),
                  const SizedBox(height: BaakasSizes.xs),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color:
                          isMe
                              ? BaakasColors.white.withOpacity(0.7)
                              : BaakasColors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isMe) const SizedBox(width: BaakasSizes.lg),
        ],
      ),
    );
  }
}
