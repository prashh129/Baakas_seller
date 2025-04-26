import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/checkout_controller.dart';

class BaakasBillingPaymentSection extends StatelessWidget {
  const BaakasBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return Column(
      children: [
        BaakasSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          showActionButton: true,
          onPressed: () {
            controller.selectPaymentMethod(context);
          },
        ),
        const SizedBox(height: BaakasSizes.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              BaakasRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor:
                    BaakasHelperFunctions.isDarkMode(context)
                        ? BaakasColors.light
                        : BaakasColors.white,
                padding: const EdgeInsets.all(BaakasSizes.sm),
                child: Image(
                  image: AssetImage(
                    controller.selectedPaymentMethod.value.image,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: BaakasSizes.spaceBtwItems / 2),
              Text(
                controller.selectedPaymentMethod.value.name.capitalize
                    .toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
