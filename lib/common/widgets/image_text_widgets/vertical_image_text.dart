import 'package:baakas_seller/utils/constants/colors.dart';
import 'package:baakas_seller/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart' show BaakasSizes;

class BaakasVerticalImageText extends StatelessWidget {
  const BaakasVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = BaakasColors.white,
    this.backgroundColor = BaakasColors.white,
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = BaakasHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: BaakasSizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(BaakasSizes.sm),
              decoration: BoxDecoration(
                color:
                    backgroundColor ??
                    (dark ? BaakasColors.black : BaakasColors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  color: dark ? BaakasColors.dark : BaakasColors.dark,
                ),
              ),
            ),

            /// Text
            const SizedBox(height: BaakasSizes.spaceBtwItems / 2),
            SizedBox(
              width: 55,
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
