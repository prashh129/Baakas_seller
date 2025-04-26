import 'package:baakas_seller/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/sizes.dart';
import '../layouts/grid_layout.dart';

class BaakasVerticalProductShimmer extends StatelessWidget {
  const BaakasVerticalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return BaakasGridLayout(
      itemCount: itemCount,
      itemBuilder:
          (_, __) => const SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Image
                BaakasShimmerEffect(width: 180, height: 180),
                SizedBox(height: BaakasSizes.spaceBtwItems),

                /// Text
                BaakasShimmerEffect(width: 160, height: 15),
                SizedBox(height: BaakasSizes.spaceBtwItems / 2),
                BaakasShimmerEffect(width: 110, height: 15),
              ],
            ),
          ),
    );
  }
}
