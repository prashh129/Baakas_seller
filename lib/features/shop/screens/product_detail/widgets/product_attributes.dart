import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/chips/rounded_choice_chips.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../common/widgets/texts/Baakas_product_price_text.dart';
import '../../../../../common/widgets/texts/Baakas_product_title_text.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/variation_controller.dart';
import '../../../models/product_model.dart';

class BaakasProductAttributes extends StatelessWidget {
  const BaakasProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = VariationController.instance;
    controller.resetSelectedAttributes();
    return Obx(
      () => Column(
        children: [
          /// -- Selected Attribute Pricing & Description
          // Display variation price and stock when some variation is selected.
          if (controller.selectedVariation.value.id.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const BaakasSectionHeading(
                        title: 'Variation: ', showActionButton: false),
                    const SizedBox(width: BaakasSizes.spaceBtwItems),

                    /// Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Actual Price if sale price not null.
                            const BaakasProductTitleText(
                                title: 'Price : ', smallSize: true),
                            if (controller.selectedVariation.value.salePrice >
                                0)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      width: BaakasSizes.spaceBtwItems),
                                  Text(
                                    controller.selectedVariation.value.price
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .apply(
                                            decoration:
                                                TextDecoration.lineThrough),
                                  ),
                                  const SizedBox(
                                      width: BaakasSizes.spaceBtwItems)
                                ],
                              ),
                            // Sale Price if sale price not null Else Simple Price.
                            BaakasProductPriceText(
                              price: controller
                                          .selectedVariation.value.salePrice >
                                      0
                                  ? controller.selectedVariation.value.salePrice
                                      .toString()
                                  : controller.selectedVariation.value.price
                                      .toString(),
                            ),
                          ],
                        ),

                        /// Stock
                        Row(
                          children: [
                            const BaakasProductTitleText(
                                title: 'Stock : ', smallSize: true),
                            Text(
                                controller.selectedVariation.value.stock
                                    .toString(),
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                /// Description
                BaakasProductTitleText(
                  title:
                      controller.selectedVariation.value.description.toString(),
                  smallSize: true,
                  maxLines: 4,
                ),
              ],
            ),
          const SizedBox(height: BaakasSizes.spaceBtwItems),

          /// -- Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map((attribute) => Column(
                      // attribute = Product Single Attribute [Name: Color, Values: [Green, Blue, Orange]]
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaakasSectionHeading(
                            title: attribute.name ?? '',
                            showActionButton: false),
                        const SizedBox(height: BaakasSizes.spaceBtwItems / 2),
                        Obx(
                          () => Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: attribute.values!.map((attributeValue) {
                              // attributeValue = Single Attribute Value [Green]
                              final isSelected = controller
                                      .selectedAttributes[attribute.name] ==
                                  attributeValue;
                              final available = controller
                                  .getAttributesAvailabilityInVariation(
                                      product.productVariations!,
                                      attribute.name!)
                                  .contains(attributeValue);

                              /// Attribute Chip
                              return BaakasChoiceChip(
                                text: attributeValue,
                                selected: isSelected,
                                onSelected: available
                                    ? (selected) {
                                        if (selected && available) {
                                          controller.onAttributeSelected(
                                              product,
                                              attribute.name ?? '',
                                              attributeValue);
                                        }
                                      }
                                    : null,
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: BaakasSizes.spaceBtwItems),
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
