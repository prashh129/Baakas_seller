import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/sizes.dart';

class BaakasMessageIcon extends StatelessWidget {
  final double? size;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? borderRadius;

  const BaakasMessageIcon({
    super.key,
    this.size = 50,
    this.backgroundColor,
    this.iconColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(
          borderRadius ?? BaakasSizes.cardRadiusMd,
        ),
      ),
      child: Icon(Iconsax.message, color: iconColor),
    );
  }
}
