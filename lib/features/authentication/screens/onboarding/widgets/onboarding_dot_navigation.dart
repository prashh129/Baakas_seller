import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/onboarding_controller.dart';

class BaakasOnBoardingDotNavigation extends StatelessWidget {
  const BaakasOnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = BaakasHelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: BaakasDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: BaakasSizes.defaultSpace,
      child: SmoothPageIndicator(
        count: 3,
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        effect: ExpandingDotsEffect(
            activeDotColor: dark ? BaakasColors.white : BaakasColors.black,
            dotHeight: 6),
      ),
    );
  }
}
