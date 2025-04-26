import 'package:baakas_seller/utils/constants/colors.dart';
import 'package:baakas_seller/utils/constants/sizes.dart';
import 'package:baakas_seller/utils/device/device_utility.dart';
import 'package:baakas_seller/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BaakasSearchContainer extends StatelessWidget {
  const BaakasSearchContainer({
    super.key,
    required this.text,
    this.showBackground = true,
    this.showBoarder = true,
    this.icon = Iconsax.search_normal,
    this.onTap,
  });
  final String text;
  final IconData? icon;
  final bool showBackground, showBoarder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = BaakasHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: BaakasSizes.defaultSpace,
        ),
        child: Container(
          width: BaakasDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(BaakasSizes.md),
          decoration: BoxDecoration(
            color:
                showBackground
                    ? dark
                        ? BaakasColors.dark
                        : BaakasColors.light
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(BaakasSizes.cardRadiusLg),
            border: showBoarder ? Border.all(color: BaakasColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: BaakasColors.darkerGrey),
              const SizedBox(width: BaakasSizes.spaceBtwItems),
              Text(text, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
