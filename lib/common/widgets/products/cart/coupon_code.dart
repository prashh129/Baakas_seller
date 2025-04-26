import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../custom_shapes/containers/rounded_container.dart';

class BaakasCouponCode extends StatelessWidget {
  const BaakasCouponCode({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BaakasRoundedContainer(
      showBorder: true,
      backgroundColor: isDark ? BaakasColors.dark : BaakasColors.white,
      padding: const EdgeInsets.only(
          top: BaakasSizes.sm,
          bottom: BaakasSizes.sm,
          right: BaakasSizes.sm,
          left: BaakasSizes.md),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// TextField
          Flexible(
            child: TextFormField(
              expands: false,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Have a promo code? Enter here',
              ),
            ),
          ),

          /// Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: isDark
                    ? BaakasColors.white.withOpacity(0.5)
                    : BaakasColors.dark.withOpacity(0.5),
                backgroundColor: Colors.grey.withOpacity(0.2),
                side: BorderSide(color: Colors.grey.withOpacity(0.1)),
              ),
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }
}
