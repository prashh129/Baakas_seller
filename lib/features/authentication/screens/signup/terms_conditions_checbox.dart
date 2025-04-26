import 'package:baakas_seller/utils/constants/sizes.dart';
import 'package:baakas_seller/utils/constants/text_strings.dart';
import 'package:baakas_seller/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class BaakasTermsAndConditionCheckbox extends StatelessWidget {
  const BaakasTermsAndConditionCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = BaakasHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(value: true, onChanged: (value) {}),
        ),
        const SizedBox(width: BaakasSizes.spaceBtwItems),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${BaakasTexts.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: '${BaakasTexts.privacyPolicy} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? BaakasColors.white : BaakasColors.primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor:
                      dark ? BaakasColors.white : BaakasColors.primaryColor,
                ),
              ),
              TextSpan(
                text: '${BaakasTexts.and} ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: '${BaakasTexts.termsOfUse} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? BaakasColors.white : BaakasColors.primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor:
                      dark ? BaakasColors.white : BaakasColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
