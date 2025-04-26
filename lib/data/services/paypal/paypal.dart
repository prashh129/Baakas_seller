import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../utils/constants/api_constants.dart';

class TPaypalService {
  static final _logger = Logger();
  
  static Future<bool> getPayment() async {
    bool success = false;
    Get.to(() => UsePaypal(
      sandboxMode: true,
      clientId: TAPIs.paypalSandboxClientId,
      secretKey: TAPIs.paypalSandboxSecretKey,
      returnURL: "https://codingwitht.com/",
      cancelURL: "https://codingwitht.com/",
      transactions: const [
        {
          "amount": {
            "total": '10.12',
            "currency": "USD",
            "details": {"subtotal": '10.12', "shipping": '0', "shipping_discount": 0}
          },
          "description": "The payment transaction description.",
          // "payment_options": {
          //   "allowed_payment_method":
          //       "INSTANT_FUNDING_SOURCE"
          // },
          "item_list": {
            "items": [
              {"name": "A demo product", "quantity": 1, "price": '10.12', "currency": "USD"}
            ],

            // shipping address is not required though
            "shipping_address": {
              "recipient_name": "Jane Foster",
              "line1": "Travis County",
              "line2": "",
              "city": "Austin",
              "country_code": "US",
              "postal_code": "73301",
              "phone": "+00000000",
              "state": "Texas"
            },
          }
        }
      ],
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) async {
        _logger.i("Payment successful: $params");
        success = true;
      },
      onError: (error) {
        _logger.e("Payment error: $error");
        success = false;
      },
      onCancel: (params) {
        _logger.w("Payment cancelled: $params");
        success = false;
      },
    ));

    return success;
  }
}
