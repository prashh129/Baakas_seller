import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class BaakasChipTheme {
  BaakasChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    checkmarkColor: BaakasColors.white,
    selectedColor: BaakasColors.primaryColor,
    disabledColor: BaakasColors.grey.withValues(alpha: 102),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: const TextStyle(
      color: BaakasColors.black,
      fontFamily: 'Poppins',
      fontSize: 14,
    ),
    backgroundColor: BaakasColors.grey.withValues(alpha: 51),
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    checkmarkColor: BaakasColors.white,
    selectedColor: BaakasColors.primaryColor,
    disabledColor: BaakasColors.darkerGrey,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: const TextStyle(
      color: BaakasColors.white,
      fontFamily: 'Poppins',
      fontSize: 14,
    ),
    backgroundColor: BaakasColors.darkGrey.withValues(alpha: 51),
  );
}
