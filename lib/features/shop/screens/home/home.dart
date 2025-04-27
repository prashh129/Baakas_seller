import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/cards/section_card.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import 'widgets/home_appbar.dart';
import '../../../reviews/screens/reviews_screen.dart';
import '../../../promotions/screens/promotions_screen.dart';
import '../../../support/screens/help_center_screen.dart';
import 'widgets/earnings_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = BaakasHelperFunctions.isDarkMode(context);
    
    return Scaffold(
      backgroundColor: isDark ? BaakasColors.dark : BaakasColors.light,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            Container(
              decoration: BoxDecoration(
                color: BaakasColors.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(BaakasSizes.cardRadiusLg),
                  bottomRight: Radius.circular(BaakasSizes.cardRadiusLg),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Appbar
                  const BaakasHomeAppBar(),
                  const SizedBox(height: BaakasSizes.spaceBtwSections),
                ],
              ),
            ),

            /// -- Body
            Container(
              padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Earnings Section
                  const EarningsSection(),
                  const SizedBox(height: BaakasSizes.spaceBtwSections),

                  /// -- Reviews Section
                  BaakasSectionCard(
                    title: 'Customer Reviews',
                    subtitle: 'View and manage customer reviews',
                    icon: Iconsax.star,
                    onTap: () => Get.to(() => const ReviewsScreen()),
                  ),
                  const SizedBox(height: BaakasSizes.spaceBtwSections),

                  // Promotions Section
                  BaakasSectionCard(
                    title: 'Promotions & Discounts',
                    subtitle: 'Manage coupons and seasonal offers',
                    icon: Iconsax.discount_shape,
                    iconSize: 32,
                    onTap: () => Get.to(() => const PromotionsScreen()),
                  ),
                  const SizedBox(height: BaakasSizes.spaceBtwSections),

                  // Help Center Section
                  BaakasSectionCard(
                    title: 'Help Center',
                    subtitle: 'Access FAQs, guides, and support tickets',
                    icon: Iconsax.message_question,
                    onTap: () => Get.to(() => const HelpCenterScreen()),
                  ),
                  const SizedBox(height: BaakasSizes.spaceBtwSections),

                  SizedBox(
                    height: BaakasDeviceUtils.getBottomNavigationBarHeight() + BaakasSizes.defaultSpace,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
