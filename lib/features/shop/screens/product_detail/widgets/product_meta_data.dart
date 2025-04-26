import 'package:flutter/material.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/images/Baakas_circular_image.dart';
import '../../../../../common/widgets/texts/baakas_brand_title_text_with_verified_icon.dart';
import '../../../../../common/widgets/texts/Baakas_product_price_text.dart';
import '../../../../../common/widgets/texts/Baakas_product_title_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../models/product_model.dart';

class BaakasProductMetaData extends StatelessWidget {
  const BaakasProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = ProductController.instance.calculateSalePercentage(
      product.price,
      product.salePrice,
    );
    final darkMode = BaakasHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// -- Sale Tag
            if (salePercentage != null)
              Row(
                children: [
                  BaakasRoundedContainer(
                    backgroundColor: BaakasColors.secondary,
                    radius: BaakasSizes.sm,
                    padding: const EdgeInsets.symmetric(
                      horizontal: BaakasSizes.sm,
                      vertical: BaakasSizes.xs,
                    ),
                    child: Text(
                      '$salePercentage%',
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge!.apply(color: BaakasColors.black),
                    ),
                  ),
                  const SizedBox(width: BaakasSizes.spaceBtwItems),
                ],
              ),

            // Actual Price if sale price not null.
            if ((product.productVariations == null ||
                    product.productVariations!.isEmpty) &&
                product.salePrice > 0.0)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.price.toString(),
                    style: Theme.of(context).textTheme.titleSmall!.apply(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: BaakasSizes.spaceBtwItems),
                ],
              ),

            // Price, Show sale price as main price if sale exist.
            BaakasProductPriceText(
              price: controller.getProductPrice(product),
              isLarge: true,
            ),
          ],
        ),
        const SizedBox(height: BaakasSizes.spaceBtwItems / 1.5),
        BaakasProductTitleText(title: product.title),
        const SizedBox(height: BaakasSizes.spaceBtwItems / 1.5),
        Row(
          children: [
            const BaakasProductTitleText(title: 'Stock : ', smallSize: true),
            Text(
              controller.getProductStockStatus(product),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: BaakasSizes.spaceBtwItems / 2),

        /// Brand
        Row(
          children: [
            BaakasCircularImage(
              width: 32,
              height: 32,
              isNetworkImage: true,
              image: product.brand!.image,
              overlayColor: darkMode ? BaakasColors.white : BaakasColors.black,
            ),
            BaakasBrandTitleWithVerifiedIcon(
              title: product.brand!.name,
              brandTextSize: TextSizes.medium,
            ),
          ],
        ),
      ],
    );
  }
}
