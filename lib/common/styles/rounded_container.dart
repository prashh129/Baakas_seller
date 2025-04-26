import 'package:baakas_seller/utils/constants/colors.dart';
import 'package:baakas_seller/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BaakasRoundedContainer extends StatelessWidget {
  const BaakasRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = BaakasSizes.cardRadiusLg,
    this.child,
    this.showBorder = false,
    this.borderColor = BaakasColors.borderPrimary,
    this.backgroundColor = BaakasColors.white,
    this.padding,
    this.margin,
  });

  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
