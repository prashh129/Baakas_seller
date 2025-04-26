import 'package:baakas_seller/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/shop/controllers/notification_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());
    final dark = BaakasHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: const BaakasAppBar(
        showBackArrow: true,
        title: Text("Notifications"),
      ),

      body: Obx(
        () =>
            controller.notifications.isEmpty
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.notification,
                        size: 50,
                        color: dark ? BaakasColors.white : BaakasColors.black,
                      ),
                      const SizedBox(height: BaakasSizes.spaceBtwItems),
                      Text(
                        'No notifications yet',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                )
                : ListView.separated(
                  padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
                  itemCount: controller.notifications.length,
                  separatorBuilder:
                      (_, __) =>
                          const SizedBox(height: BaakasSizes.spaceBtwItems),
                  itemBuilder: (context, index) {
                    final notification = controller.notifications[index];
                    return Container(
                      decoration: BoxDecoration(
                        color:
                            notification.isRead
                                ? Colors.transparent
                                : (dark
                                    ? BaakasColors.darkerGrey
                                    : BaakasColors.light),
                        borderRadius: BorderRadius.circular(
                          BaakasSizes.cardRadiusLg,
                        ),
                      ),
                      child: ListTile(
                        leading:
                            notification.imageUrl != null
                                ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    notification.imageUrl!,
                                  ),
                                )
                                : CircleAvatar(
                                  backgroundColor:
                                      dark
                                          ? BaakasColors.dark
                                          : BaakasColors.primaryColor,
                                  child: const Icon(
                                    Iconsax.notification,
                                    color: BaakasColors.white,
                                  ),
                                ),
                        title: Text(
                          notification.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification.message,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: BaakasSizes.xs),
                            Text(
                              _formatTimeAgo(notification.timestamp),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        trailing:
                            !notification.isRead
                                ? IconButton(
                                  onPressed:
                                      () => controller.markAsRead(
                                        notification.id,
                                      ),
                                  icon: const Icon(Iconsax.tick_circle),
                                )
                                : null,
                        onTap: () {
                          if (!notification.isRead) {
                            controller.markAsRead(notification.id);
                          }
                        },
                      ),
                    );
                  },
                ),
      ),
    );
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
