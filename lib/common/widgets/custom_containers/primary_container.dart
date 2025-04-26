import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class BaakasPrimaryContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final bool showBackgroundColor;
  final VoidCallback? onTap;

  const BaakasPrimaryContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(BaakasSizes.md),
    this.margin = const EdgeInsets.all(BaakasSizes.xs),
    this.borderRadius = BaakasSizes.cardRadiusLg,
    this.showBackgroundColor = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(BaakasSizes.md),
        margin: margin,
        decoration: BoxDecoration(
          color:
              showBackgroundColor
                  ? dark
                      ? const Color(
                        0xFF1C1C1E,
                      ) // Dark theme background color from image
                      : Colors.white
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(
            borderRadius ?? BaakasSizes.cardRadiusLg,
          ),
          border: Border.all(color: BaakasColors.grey.withOpacity(0.1)),
        ),
        child: child,
      ),
    );
  }
}

// Secondary container with border
class BaakasSecondaryContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final bool showBorder;

  const BaakasSecondaryContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: padding ?? const EdgeInsets.all(BaakasSizes.md),
      margin: margin,
      decoration: BoxDecoration(
        color: dark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(
          borderRadius ?? BaakasSizes.cardRadiusLg,
        ),
        border:
            showBorder
                ? Border.all(
                  color: dark ? BaakasColors.darkGrey : BaakasColors.grey,
                  width: 1,
                )
                : null,
      ),
      child: child,
    );
  }
}
