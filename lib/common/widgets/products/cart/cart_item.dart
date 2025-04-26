import 'package:flutter/material.dart';

import '../../../../features/shop/models/cart_item_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/Baakas_rounded_image.dart';
import '../../texts/baakas_brand_title_text_with_verified_icon.dart';
import '../../texts/Baakas_product_title_text.dart';

class BaakasCartItem extends StatelessWidget {
  const BaakasCartItem({
    super.key,
    required this.item,
  });

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final dark = BaakasHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        /// 1 - Image
        BaakasRoundedImage(
          width: 60,
          height: 60,
          isNetworkImage: true,
          imageUrl: item.image ?? '',
          padding: const EdgeInsets.all(BaakasSizes.sm),
          backgroundColor: dark ? BaakasColors.darkerGrey : BaakasColors.light,
        ),
        const SizedBox(width: BaakasSizes.spaceBtwItems),

        /// 2 - Title, Price, & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Brand and Title
              BaakasBrandTitleWithVerifiedIcon(title: item.brandName ?? ''),
              Flexible(
                  child:
                      BaakasProductTitleText(title: item.title, maxLines: 1)),

              /// Attributes
              Text.rich(
                TextSpan(
                  children: (item.selectedVariation ?? {})
                      .entries
                      .map(
                        (e) => TextSpan(
                          children: [
                            TextSpan(
                                text: ' ${e.key} ',
                                style: Theme.of(context).textTheme.bodySmall),
                            TextSpan(
                                text: '${e.value} ',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
