import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class BaakasLoginHeader extends StatelessWidget {
  const BaakasLoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = BaakasHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 80,
          image: AssetImage(
            dark ? BaakasImages.lightAppLogo : BaakasImages.darkAppLogo,
          ),
        ),
        const SizedBox(height: BaakasSizes.spaceBtwItems),
        Text(
          BaakasTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: BaakasSizes.sm),
        Text(
          BaakasTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
