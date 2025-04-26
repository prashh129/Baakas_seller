import 'package:baakas_seller/features/shop/controllers/product/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/products/cart/billing_amount_section.dart';
import '../../../../common/widgets/products/cart/coupon_code.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/address_controller.dart';
import '../../controllers/product/cart_controller.dart';
import '../../controllers/product/order_controller.dart';
import '../cart/widgets/cart_items.dart';
import 'widgets/billing_address_section.dart';
import 'widgets/billing_payment_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutController = CheckoutController.instance;
    final cartController = CartController.instance;
    final addressController = AddressController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final dark = BaakasHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const BaakasAppBar(
        title: Text('Order Review'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// -- Items in Cart
              const BaakasCartItems(showAddRemoveButtons: false),
              const SizedBox(height: BaakasSizes.spaceBtwSections),

              /// -- Coupon TextField
              const BaakasCouponCode(),
              const SizedBox(height: BaakasSizes.spaceBtwSections),

              /// -- Billing Section
              BaakasRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(BaakasSizes.md),
                backgroundColor: dark ? BaakasColors.black : BaakasColors.white,
                child: Column(
                  children: [
                    /// Pricing
                    BaakasBillingAmountSection(subTotal: subTotal),
                    const SizedBox(height: BaakasSizes.spaceBtwItems),

                    /// Divider
                    const Divider(),
                    const SizedBox(height: BaakasSizes.spaceBtwItems),

                    /// Payment Methods
                    const BaakasBillingPaymentSection(),
                    const SizedBox(height: BaakasSizes.spaceBtwSections),

                    /// Address
                    const BaakasAddressSection(isBillingAddress: false),
                    const SizedBox(height: BaakasSizes.spaceBtwItems),

                    /// Divider
                    const Divider(),
                    const SizedBox(height: BaakasSizes.spaceBtwItems),

                    /// Address Checkbox
                    Obx(
                      () => CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text(
                          'Billing Address is Same as Shipping Address',
                        ),
                        value: addressController.billingSameAsShipping.value,
                        onChanged:
                            (value) =>
                                addressController.billingSameAsShipping.value =
                                    value ?? true,
                      ),
                    ),
                    const SizedBox(height: BaakasSizes.spaceBtwItems),

                    /// Divider
                    Obx(
                      () =>
                          !addressController.billingSameAsShipping.value
                              ? const Divider()
                              : const SizedBox.shrink(),
                    ),

                    /// Shipping Address
                    Obx(
                      () =>
                          !addressController.billingSameAsShipping.value
                              ? const BaakasAddressSection(
                                isBillingAddress: true,
                              )
                              : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: BaakasSizes.spaceBtwSections),
            ],
          ),
        ),
      ),

      /// -- Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                subTotal > 0
                    ? () => orderController.processOrder(subTotal)
                    : () => BaakasLoaders.warningSnackBar(
                      title: 'Empty Cart',
                      message: 'Add items in the cart in order to proceed.',
                    ),
            child: Text(
              'Checkout Rs ${checkoutController.getTotal(subTotal).toStringAsFixed(2)}',
            ),
          ),
        ),
      ),
    );
  }
}
