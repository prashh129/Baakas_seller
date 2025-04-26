import 'package:flutter/material.dart';
import '../../../utils/constants/sizes.dart';
import 'shimmer.dart';

class BaakasHorizontalProductShimmer extends StatelessWidget {
  const BaakasHorizontalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: BaakasSizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder:
            (context, index) =>
                const SizedBox(width: BaakasSizes.spaceBtwItems),
        itemBuilder:
            (_, __) => const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Image
                BaakasShimmerEffect(width: 120, height: 120),
                SizedBox(width: BaakasSizes.spaceBtwItems),

                /// Text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: BaakasSizes.spaceBtwItems / 2),
                    BaakasShimmerEffect(width: 160, height: 15),
                    SizedBox(height: BaakasSizes.spaceBtwItems / 2),
                    BaakasShimmerEffect(width: 110, height: 15),
                    SizedBox(height: BaakasSizes.spaceBtwItems / 2),
                    BaakasShimmerEffect(width: 80, height: 15),
                    Spacer(),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}
