import 'package:baakas_seller/utils/constants/colors.dart';
import 'package:flutter/rendering.dart';

class BaakasShadowStyle {
  static final verticalProductShadow = BoxShadow(
    color: BaakasColors.darkGrey.withValues(alpha: 0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );

  static final horizontalProductShadow = BoxShadow(
    color: BaakasColors.darkGrey.withValues(alpha: 0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );
}
