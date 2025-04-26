import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class BaakasTextFormFieldTheme {
  BaakasTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: BaakasColors.darkGrey,
    suffixIconColor: BaakasColors.darkGrey,
    labelStyle: const TextStyle().copyWith(
      fontSize: BaakasSizes.fontMd,
      color: BaakasColors.black,
      fontFamily: 'Poppins',
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: BaakasSizes.fontSm,
      color: BaakasColors.darkGrey,
      fontFamily: 'Poppins',
    ),
    errorStyle: const TextStyle().copyWith(
      fontStyle: FontStyle.normal,
      fontFamily: 'Poppins',
    ),
    floatingLabelStyle: const TextStyle().copyWith(
      color: BaakasColors.black.withOpacity(0.8),
      fontFamily: 'Poppins',
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(BaakasSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: BaakasColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(BaakasSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: BaakasColors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(BaakasSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: BaakasColors.primaryColor),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(BaakasSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: BaakasColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(BaakasSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: BaakasColors.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: BaakasColors.grey,
    suffixIconColor: BaakasColors.grey,
    labelStyle: const TextStyle().copyWith(
      fontSize: BaakasSizes.fontMd,
      color: BaakasColors.white,
      fontFamily: 'Poppins',
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: BaakasSizes.fontSm,
      color: BaakasColors.grey,
      fontFamily: 'Poppins',
    ),
    floatingLabelStyle: const TextStyle().copyWith(
      color: BaakasColors.white.withOpacity(0.8),
      fontFamily: 'Poppins',
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(BaakasSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: BaakasColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(BaakasSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: BaakasColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(BaakasSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: BaakasColors.primaryColor),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(BaakasSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: BaakasColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(BaakasSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: BaakasColors.warning),
    ),
  );
}
