import 'package:baakas_seller/common/widgets/shimmers/shimmer.dart';
import 'package:baakas_seller/features/personalization/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/icons/message_counter_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../personalization/controllers/user_controller.dart';
import '../../../../personalization/screens/profile/profile.dart';

class BaakasHomeAppBar extends StatelessWidget {
  const BaakasHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Just to create instance and fetch values
    Get.put(SettingsController());
    final userController = Get.put(UserController());

    return BaakasAppBar(
      title: GestureDetector(
        onTap: () => Get.to(() => const ProfileScreen()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              BaakasTexts.homeAppbarTitle,
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.apply(color: BaakasColors.grey),
            ),
            Obx(() {
              // Check if user Profile is still loading
              if (userController.profileLoading.value) {
                // Display a shimmer loader while user profile is being loaded
                return const BaakasShimmerEffect(width: 80, height: 15);
              } else {
                // Check if there are no record found
                if (userController.user.value.id.isEmpty) {
                  // Display a message when no data is found
                  return Text(
                    'Your Name',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall!.apply(color: BaakasColors.white),
                  );
                } else {
                  // Display User Name
                  return Text(
                    userController.user.value.fullName,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall!.apply(color: BaakasColors.white),
                  );
                }
              }
            }),
          ],
        ),
      ),
      actions: const [
        BaakasMessageCounterIcon(
          iconColor: BaakasColors.white,
          counterBgColor: BaakasColors.black,
          counterTextColor: BaakasColors.white,
        ),
      ],
    );
  }
}
