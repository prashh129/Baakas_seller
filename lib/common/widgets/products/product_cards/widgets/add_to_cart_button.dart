import 'package:baakas_seller/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../features/shop/controllers/product/cart_controller.dart';
import '../../../../../features/shop/screens/product_detail/product_detail.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return GestureDetector(
      onTap: () {
        // If the product have variations then show the product Details for variation selection.
        // ELse add product to the cart.
        if (product.productType == ProductType.single.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetailScreen(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart = cartController.getProductQuantityInCart(
          product.id,
        );
        return AnimatedContainer(
          curve: Curves.easeInOutCubicEmphasized,
          decoration: BoxDecoration(
            color:
                productQuantityInCart > 0
                    ? BaakasColors.primaryColor
                    : BaakasColors.dark,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(BaakasSizes.cardRadiusMd),
              bottomRight: Radius.circular(BaakasSizes.productImageRadius),
            ),
          ),
          duration: const Duration(milliseconds: 300),
          child: SizedBox(
            width: BaakasSizes.iconLg * 1.2,
            height: BaakasSizes.iconLg * 1.2,
            child: Center(
              child:
                  productQuantityInCart > 0
                      ? Text(
                        productQuantityInCart.toString(),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.apply(color: BaakasColors.white),
                      )
                      : const Icon(Iconsax.add, color: BaakasColors.white),
            ),
          ),
        );
      }),
    );
  }
}
