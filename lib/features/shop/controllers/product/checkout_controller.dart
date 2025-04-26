import 'package:baakas_seller/common/widgets/payment/creditCard_payment_screen.dart';
import 'package:baakas_seller/common/widgets/payment/esewa_payment_screen.dart';
import 'package:baakas_seller/common/widgets/payment/khalti_payment_screen.dart';
import 'package:baakas_seller/common/widgets/payment/visa_payment.dart';
import 'package:baakas_seller/features/personalization/controllers/settings_controller.dart';
import 'package:baakas_seller/features/shop/controllers/product/cart_controller.dart';
import 'package:baakas_seller/features/shop/screens/checkout/checkout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/payment_method_model.dart';
import '../../screens/checkout/widgets/payment_tile.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final settingsController = Get.put(SettingsController());
  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  // Assuming this is where orderId is being generated or available
  final String orderId = "some_order_id"; // Replace with actual order ID logic

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(
      name: PaymentMethods.paypal.name,
      image: BaakasImages.paypal,
    );
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder:
          (_) => SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(BaakasSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BaakasSectionHeading(
                    title: 'Select Payment Method',
                    showActionButton: false,
                  ),
                  const SizedBox(height: BaakasSizes.spaceBtwSections),
                  BaakasPaymentTile(
                    paymentMethod: PaymentMethodModel(
                      name: 'VISA',
                      image: BaakasImages.visa,
                    ),
                    onTap: () async {
                      final result = await Get.to(
                        () => const VisaCardDetailsScreen(),
                      );
                      if (result == true) {
                        Get.off(() => const CheckoutScreen());
                      }
                    },
                  ),
                  const SizedBox(height: BaakasSizes.spaceBtwItems / 2),
                  BaakasPaymentTile(
                    paymentMethod: PaymentMethodModel(
                      name: 'Credit Card',
                      image: BaakasImages.creditCard,
                    ),
                    onTap: () {
                      Get.to(() => const CreditCardDetailsScreen());
                    },
                  ),
                  BaakasPaymentTile(
                    paymentMethod: PaymentMethodModel(
                      name: 'Esewa',
                      image: BaakasImages.esewa,
                    ),
                    onTap: () {
                      final cartController = Get.put(CartController());
                      double subTotal =
                          cartController.totalCartPrice.value; // Use this
                      double totalAmount = getTotal(
                        subTotal,
                      ); // Get the total amount
                      Get.to(
                        () => EsewaPaymentScreen(amount: totalAmount),
                      ); // Pass the totalAmount
                    },
                  ),

                  const SizedBox(height: BaakasSizes.spaceBtwItems / 2),

                  // BaakasPaymentTile(
                  //   paymentMethod: PaymentMethodModel(
                  //     name: 'Khalti',
                  //     image: BaakasImages.khalti,
                  //   ),
                  //   onTap: () {
                  //     Get.to(() => KhaltiPaymentScreen(amount: null,));
                  //   },
                  // ),
                  BaakasPaymentTile(
                    paymentMethod: PaymentMethodModel(
                      name: 'Khalti',
                      image: BaakasImages.khalti,
                    ),
                    onTap: () {
                      final cartController = Get.put(CartController());
                      double subTotal =
                          cartController.totalCartPrice.value; // Use this
                      double totalAmount = getTotal(
                        subTotal,
                      ); // Get the total amount
                      Get.to(
                        () => KhaltiPaymentScreen(amount: totalAmount),
                      ); // Pass the totalAmount
                    },
                  ),

                  const SizedBox(height: BaakasSizes.spaceBtwItems / 2),
                  BaakasPaymentTile(
                    paymentMethod: PaymentMethodModel(
                      name: 'Cash On Delivery',
                      image: BaakasImages.cod,
                    ),
                    onTap: () {
                      // Close the bottom sheet when "Cash On Delivery" is selected
                      Navigator.pop(context);

                      // Optionally, you can set the selected payment method to COD here
                      selectedPaymentMethod.value = PaymentMethodModel(
                        name: 'Cash On Delivery',
                        image: BaakasImages.cod,
                      );
                    },
                  ),
                  const SizedBox(height: BaakasSizes.spaceBtwItems / 2),
                  const SizedBox(height: BaakasSizes.spaceBtwSections),
                ],
              ),
            ),
          ),
    );
  }

  bool isShippingFree(double subTotal) {
    if (settingsController.settings.value.freeShippingThreshold != null &&
        settingsController.settings.value.freeShippingThreshold! > 0.0) {
      if (subTotal > settingsController.settings.value.freeShippingThreshold!) {
        return true;
      }
    }
    return false;
  }

  double getShippingCost(double subTotal) {
    return isShippingFree(subTotal)
        ? 0
        : settingsController.settings.value.shippingCost;
  }

  double getTaxAmount(double subTotal) {
    return settingsController.settings.value.taxRate * subTotal;
  }

  double getTotal(double subTotal) {
    double taxAmount = subTotal * settingsController.settings.value.taxRate;
    double totalPrice =
        subTotal +
        taxAmount +
        (isShippingFree(subTotal)
            ? 0
            : settingsController.settings.value.shippingCost);
    return double.tryParse(totalPrice.toStringAsFixed(2)) ?? 0.0;
  }
}

// /// Third code start from here
