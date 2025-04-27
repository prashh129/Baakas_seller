import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/custom_containers/primary_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class BaakasChatListItem extends StatelessWidget {
  const BaakasChatListItem({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isAdmin = false,
    required this.onTap,
  });

  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isAdmin;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BaakasPrimaryContainer(
      onTap: onTap,
      child: Row(
        children: [
          // Avatar or Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color:
                  isAdmin
                      ? BaakasColors.primaryColor
                      : BaakasColors.grey.withValues(alpha: 51),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isAdmin ? Iconsax.support : Iconsax.user,
              color: isAdmin ? BaakasColors.white : BaakasColors.dark,
            ),
          ),

          const SizedBox(width: BaakasSizes.spaceBtwItems),

          // Message Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.titleMedium),
                    Text(time, style: Theme.of(context).textTheme.labelMedium),
                  ],
                ),
                const SizedBox(height: BaakasSizes.xs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        lastMessage,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (unreadCount > 0)
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: BaakasColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          unreadCount.toString(),
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: BaakasColors.white),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
