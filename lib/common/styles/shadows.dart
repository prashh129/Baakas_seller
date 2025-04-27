import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class BaakasShadowStyle {
  static final verticalProductShadow = BoxShadow(
      color: BaakasColors.darkGrey.withValues(alpha: 26),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
  static final horizontalProductShadow = BoxShadow(
      color: BaakasColors.darkGrey.withValues(alpha: 26),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
}
