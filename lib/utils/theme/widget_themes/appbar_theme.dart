import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class BaakasAppBarTheme {
  BaakasAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme:
        IconThemeData(color: BaakasColors.black, size: BaakasSizes.iconMd),
    actionsIconTheme:
        IconThemeData(color: BaakasColors.black, size: BaakasSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: BaakasColors.black,
        fontFamily: 'Poppins'),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme:
        IconThemeData(color: BaakasColors.white, size: BaakasSizes.iconMd),
    actionsIconTheme:
        IconThemeData(color: BaakasColors.white, size: BaakasSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: BaakasColors.white,
        fontFamily: 'Poppins'),
  );
}
