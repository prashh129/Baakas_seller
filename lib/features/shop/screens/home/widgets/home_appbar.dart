import 'package:baakas_seller/common/widgets/shimmers/shimmer.dart';
import 'package:baakas_seller/features/personalization/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/icons/message_counter_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../personalization/controllers/user_controller.dart';
import '../../../../personalization/screens/profile/profile.dart';

class BaakasHomeAppBar extends StatelessWidget {
  const BaakasHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = BaakasHelperFunctions.isDarkMode(context);
    final userController = Get.put(UserController());
    Get.put(SettingsController());

    return BaakasAppBar(
      title: GestureDetector(
        onTap: () => Get.to(() => const ProfileScreen()),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: BaakasSizes.sm),
          child: Row(
            children: [
              Hero(
                tag: 'profile_avatar',
                child: Container(
                  padding: const EdgeInsets.all(BaakasSizes.sm),
                  decoration: BoxDecoration(
                    color: isDark ? BaakasColors.darkContainer : BaakasColors.softGrey,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: BaakasColors.primaryColor.withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Obx(() {
                    if (userController.profileLoading.value) {
                      return const BaakasShimmerEffect(width: 24, height: 24);
                    } else {
                      return Icon(
                        Iconsax.user,
                        color: isDark ? BaakasColors.white : BaakasColors.primaryColor,
                        size: 20,
                      );
                    }
                  }),
                ),
              ),
              const SizedBox(width: BaakasSizes.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: BaakasSizes.xs),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: child,
                        );
                      },
                      child: Text(
                        'Welcome Back!',
                        style: Theme.of(context).textTheme.titleMedium?.apply(
                          color: BaakasColors.white.withOpacity(0.8),
                          fontSizeDelta: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: BaakasSizes.xs),
                    Obx(() {
                      if (userController.profileLoading.value) {
                        return const BaakasShimmerEffect(width: 80, height: 15);
                      } else {
                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, 10 * (1 - value)),
                              child: Opacity(
                                opacity: value,
                                child: child,
                              ),
                            );
                          },
                          child: Text(
                            userController.user.value.id.isEmpty
                                ? 'Your Name'
                                : userController.user.value.fullName,
                            style: Theme.of(context).textTheme.headlineSmall?.apply(
                              color: BaakasColors.white,
                              fontWeightDelta: 2,
                              fontSizeDelta: 2,
                            ),
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: BaakasSizes.md),
          child: const BaakasMessageCounterIcon(
            iconColor: BaakasColors.white,
            counterBgColor: BaakasColors.black,
            counterTextColor: BaakasColors.white,
          ),
        ),
      ],
    );
  }
}
