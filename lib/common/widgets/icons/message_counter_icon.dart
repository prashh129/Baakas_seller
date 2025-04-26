import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../features/shop/controllers/message_controller.dart';
import '../../../features/shop/controllers/notification_controller.dart';
import '../../../features/communication/screens/customer_communication_screen.dart';
import '../../../features/communication/screens/notifications_screen.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class BaakasMessageCounterIcon extends StatelessWidget {
  const BaakasMessageCounterIcon({
    super.key,
    this.iconColor,
    this.counterBgColor,
    this.counterTextColor,
  });

  final Color? iconColor, counterBgColor, counterTextColor;

  @override
  Widget build(BuildContext context) {
    final dark = BaakasHelperFunctions.isDarkMode(context);
    final messageController = Get.put(MessageController());
    final notificationController = Get.put(NotificationController());

    return Row(
      children: [
        Stack(
          children: [
            IconButton(
              onPressed: () => Get.to(() => const NotificationsScreen()),
              icon: Icon(Iconsax.notification, color: iconColor),
            ),
            Positioned(
              right: 0,
              child: Obx(
                () =>
                    notificationController.notificationCount > 0
                        ? Container(
                          width: BaakasSizes.fontLg,
                          height: BaakasSizes.fontLg,
                          decoration: BoxDecoration(
                            color:
                                counterBgColor ??
                                (dark
                                    ? BaakasColors.white
                                    : BaakasColors.black),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Text(
                              notificationController.notificationCount
                                  .toString(),
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge!.apply(
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
        ),
        Stack(
          children: [
            IconButton(
              onPressed:
                  () => Get.to(() => const CustomerCommunicationScreen()),
              icon: Icon(Iconsax.message, color: iconColor),
            ),
            Positioned(
              right: 0,
              child: Container(
                width: BaakasSizes.fontLg,
                height: BaakasSizes.fontLg,
                decoration: BoxDecoration(
                  color:
                      counterBgColor ??
                      (dark ? BaakasColors.white : BaakasColors.black),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Obx(
                    () => Text(
                      messageController.messageCount.value.toString(),
                      style: Theme.of(context).textTheme.labelLarge!.apply(
                        color:
                            counterTextColor ??
                            (dark ? BaakasColors.black : BaakasColors.white),
                        fontSizeFactor: 0.8,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
