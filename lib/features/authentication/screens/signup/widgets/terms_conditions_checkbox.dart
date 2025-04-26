import 'package:baakas_seller/utils/device/device_utility.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/signup_controller.dart';

class BaakasTermsAndConditionCheckbox extends StatelessWidget {
  const BaakasTermsAndConditionCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Row(
      children: [
        /// CHECKBOX => Wrap in a Sized box to remove extra padding
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value = value!,
            ),
          ),
        ),
        const SizedBox(width: BaakasSizes.md),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${BaakasTexts.iAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: BaakasTexts.privacyPolicy,
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap =
                            () => BaakasDeviceUtils.launchWebsiteUrl(
                              'https://codingwitht.com/',
                            ),
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color:
                        BaakasHelperFunctions.isDarkMode(context)
                            ? BaakasColors.white
                            : BaakasColors.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor:
                        BaakasHelperFunctions.isDarkMode(context)
                            ? BaakasColors.white
                            : BaakasColors.primaryColor,
                  ),
                ),
                TextSpan(
                  text: ' ${BaakasTexts.and} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: BaakasTexts.termsOfUse,
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap =
                            () => BaakasDeviceUtils.launchWebsiteUrl(
                              'https://codingwitht.com/',
                            ),
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color:
                        BaakasHelperFunctions.isDarkMode(context)
                            ? BaakasColors.white
                            : BaakasColors.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor:
                        BaakasHelperFunctions.isDarkMode(context)
                            ? BaakasColors.white
                            : BaakasColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
