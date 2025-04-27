import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class BaakasBottomSheetTheme {
  BaakasBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: BaakasColors.white,
    modalBackgroundColor: BaakasColors.white,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    modalBarrierColor: BaakasColors.black.withValues(alpha: 128),
  );

  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: BaakasColors.dark,
    modalBackgroundColor: BaakasColors.dark,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    modalBarrierColor: BaakasColors.black.withValues(alpha: 179),
  );
}
