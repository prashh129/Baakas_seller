import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../theme/widget_themes/appbar_theme.dart';
import '../theme/widget_themes/bottom_sheet_theme.dart';
import '../theme/widget_themes/checkbox_theme.dart';
import '../theme/widget_themes/chip_theme.dart';
import '../theme/widget_themes/elevated_button_theme.dart';
import '../theme/widget_themes/outlined_button_theme.dart';
import '../theme/widget_themes/text_field_theme.dart';
import '../theme/widget_themes/text_theme.dart';

class BaakasAppTheme {
  BaakasAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: BaakasColors.grey,
    brightness: Brightness.light,
    primaryColor: BaakasColors.primaryColor,
    scaffoldBackgroundColor: BaakasColors.white,
    textTheme: BaakasTextTheme.lightTextTheme,
    chipTheme: BaakasChipTheme.lightChipTheme,
    appBarTheme: BaakasAppBarTheme.lightAppBarTheme,
    checkboxTheme: BaakasCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: BaakasBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: BaakasElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: BaakasOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: BaakasTextFormFieldTheme.lightInputDecorationTheme,
    colorScheme: const ColorScheme.light(
      primary: BaakasColors.primaryColor,
      secondary: BaakasColors.secondary,
      surface: BaakasColors.white,
      error: BaakasColors.error,
      onPrimary: BaakasColors.white,
      onSecondary: BaakasColors.white,
      onSurface: BaakasColors.black,
      onError: BaakasColors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: BaakasColors.grey,
    brightness: Brightness.dark,
    primaryColor: BaakasColors.primaryColor,
    scaffoldBackgroundColor: BaakasColors.dark,
    textTheme: BaakasTextTheme.darkTextTheme,
    chipTheme: BaakasChipTheme.darkChipTheme,
    appBarTheme: BaakasAppBarTheme.darkAppBarTheme,
    checkboxTheme: BaakasCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: BaakasBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: BaakasElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: BaakasOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: BaakasTextFormFieldTheme.darkInputDecorationTheme,
    colorScheme: const ColorScheme.dark(
      primary: BaakasColors.primaryColor,
      secondary: BaakasColors.secondary,
      surface: BaakasColors.dark,
      error: BaakasColors.error,
      onPrimary: BaakasColors.white,
      onSecondary: BaakasColors.white,
      onSurface: BaakasColors.white,
      onError: BaakasColors.white,
    ),
  );
}
