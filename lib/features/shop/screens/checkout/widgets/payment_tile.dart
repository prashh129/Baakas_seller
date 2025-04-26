// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../../../utils/helpers/helper_functions.dart';
// import '../../../controllers/product/checkout_controller.dart';
// import '../../../models/payment_method_model.dart';

// class BaakasPaymentTile extends StatelessWidget {
//   const BaakasPaymentTile({
//     super.key,
//     required this.paymentMethod,
//     required Null Function() onTap,
//   });

//   final PaymentMethodModel paymentMethod;

//   @override
//   Widget build(BuildContext context) {
//     final controller = CheckoutController.instance;
//     return ListTile(
//       contentPadding: const EdgeInsets.all(0),
//       onTap: () {
//         controller.selectedPaymentMethod.value = paymentMethod;
//         Get.back();
//       },
//       leading: BaakasRoundedContainer(
//         width: 60,
//         height: 40,
//         backgroundColor:
//             BaakasHelperFunctions.isDarkMode(context)
//                 ? BaakasColors.light
//                 : BaakasColors.white,
//         padding: const EdgeInsets.all(BaakasSizes.sm),
//         child: Image(
//           image: AssetImage(paymentMethod.image),
//           fit: BoxFit.contain,
//         ),
//       ),
//       title: Text(paymentMethod.name),
//       trailing: const Icon(Iconsax.arrow_right_34),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/checkout_controller.dart';
import '../../../models/payment_method_model.dart';

class BaakasPaymentTile extends StatelessWidget {
  const BaakasPaymentTile({
    super.key,
    required this.paymentMethod,
    required this.onTap, // updated by MrBahun
  });

  final PaymentMethodModel paymentMethod;
  final VoidCallback onTap; // updated by MrBahun

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        onTap(); // trigger the custom onTap passed in — updated by MrBahun
      },
      leading: BaakasRoundedContainer(
        width: 60,
        height: 40,
        backgroundColor:
            BaakasHelperFunctions.isDarkMode(context)
                ? BaakasColors.light
                : BaakasColors.white,
        padding: const EdgeInsets.all(BaakasSizes.sm),
        child: Image(
          image: AssetImage(paymentMethod.image),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
