import 'package:flutter/material.dart';
import 'package:baakas_seller/utils/constants/colors.dart';
import 'package:baakas_seller/utils/constants/sizes.dart';
import 'package:baakas_seller/utils/constants/text_strings.dart';

class BaakasSearchContainer extends StatelessWidget {
  const BaakasSearchContainer({
    super.key,
    this.showBorder = true,
    this.showBackground = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: BaakasSizes.defaultSpace),
    this.icon = Icons.search,
    this.iconColor,
    this.hintText = BaakasTexts.search,
  });

  final bool showBorder, showBackground;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final IconData icon;
  final Color? iconColor;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: showBackground
              ? Theme.of(context).brightness == Brightness.light
                  ? BaakasColors.light
                  : BaakasColors.dark
              : Colors.transparent,
          borderRadius: BorderRadius.circular(BaakasSizes.cardRadiusLg),
          border: showBorder
              ? Border.all(
                  color: Theme.of(context).brightness == Brightness.light
                      ? BaakasColors.grey
                      : BaakasColors.darkGrey,
                )
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ??
                  (Theme.of(context).brightness == Brightness.light
                      ? BaakasColors.darkerGrey
                      : BaakasColors.white),
            ),
            const SizedBox(width: BaakasSizes.spaceBtwItems),
            Text(
              hintText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).brightness == Brightness.light
                        ? BaakasColors.darkerGrey
                        : BaakasColors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
} 