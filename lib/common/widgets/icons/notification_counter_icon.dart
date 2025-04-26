import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../features/shop/controllers/notification_controller.dart';
import '../../../common/widgets/account_setting/notifications/notifications_screen.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class BaakasNotificationCounterIcon extends StatelessWidget {
  const BaakasNotificationCounterIcon({
    super.key,
    this.iconColor,
    this.counterBgColor,
    this.counterTextColor,
  });

  final Color? iconColor, counterBgColor, counterTextColor;

  @override
  Widget build(BuildContext context) {
    final dark = BaakasHelperFunctions.isDarkMode(context);
    final controller = Get.put(NotificationController());

    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const NotificationsScreen()),
          icon: Icon(Iconsax.notification, color: iconColor),
        ),
        Positioned(
          right: 0,
          child: Obx(
            () =>
                controller.notificationCount > 0
                    ? Container(
                      width: BaakasSizes.fontLg,
                      height: BaakasSizes.fontLg,
                      decoration: BoxDecoration(
                        color:
                            counterBgColor ??
                            (dark ? BaakasColors.white : BaakasColors.black),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Text(
                          controller.notificationCount.toString(),
                          style: Theme.of(context).textTheme.labelLarge!.apply(
                            color:
                                counterTextColor ??
                                (dark
                                    ? BaakasColors.black
                                    : BaakasColors.white),
                            fontSizeFactor: 0.8,
                          ),
                        ),
                      ),
                    )
                    : const SizedBox(),
          ),
        ),
      ],
    );
  }
}
