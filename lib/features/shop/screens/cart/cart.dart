import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/cart_controller.dart';
import '../checkout/checkout.dart';
import 'widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final cartItems = controller.cartItems;
    return Scaffold(
      /// -- AppBar
      appBar: BaakasAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Obx(() {
        /// Nothing Found Widget
        final emptyWidget = BaakasAnimationLoaderWidget(
          text: 'Whoops! Cart is EMPTY.',
          animation: BaakasImages.cartAnimation,
          showAction: true,
          actionText: 'Let\'s fill it',
          // onActionPressed: () => Get.off(() => const StoreScreen()),
        );

        /// Cart Items
        return cartItems.isEmpty
            ? emptyWidget
            : const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(BaakasSizes.defaultSpace),

                /// -- Items in Cart
                child: BaakasCartItems(),
              ),
            );
      }),

      /// -- Checkout Button
      bottomNavigationBar: Obx(() {
        return cartItems.isNotEmpty
            ? Padding(
              padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const CheckoutScreen()),
                  child: Obx(
                    () =>
                        Text('Checkout Rs ${controller.totalCartPrice.value}'),
                  ),
                ),
              ),
            )
            : const SizedBox();
      }),
    );
  }
}
