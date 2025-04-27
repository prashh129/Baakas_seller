import 'package:baakas_seller/common/widgets/texts/baakas_brand_title_text.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../images/baakas_circular_image.dart';

/// A widget that displays an image with text below it in a vertical arrangement.
class BaakasVerticalImageAndText extends StatelessWidget {
  /// Constructor for [BaakasVerticalImageAndText].
  const BaakasVerticalImageAndText({
    super.key,
    this.onTap,
    required this.image,
    required this.title,
    this.backgroundColor,
    this.isNetworkImage = true,
    this.textColor = BaakasColors.white,
  });

  /// The image asset path or URL.
  final String image;

  /// The text to be displayed below the image.
  final String title;

  /// The color of the text.
  final Color textColor;

  /// Flag indicating whether the image is loaded from the network.
  final bool isNetworkImage;

  /// The background color of the widget.
  final Color? backgroundColor;

  /// Callback function when the widget is tapped.
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: BaakasSizes.spaceBtwItems),
        child: Column(
          children: [
            BaakasCircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: BaakasSizes.sm * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              overlayColor:
                  BaakasHelperFunctions.isDarkMode(context)
                      ? BaakasColors.light
                      : BaakasColors.dark,
            ),
            const SizedBox(height: BaakasSizes.spaceBtwItems / 2),
            SizedBox(
              width: 55,
              child: BaakasBrandTitleText(title: title, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
