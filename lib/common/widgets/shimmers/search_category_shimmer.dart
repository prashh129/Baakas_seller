import 'package:baakas_seller/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/sizes.dart';

class BaakasSearchCategoryShimmer extends StatelessWidget {
  const BaakasSearchCategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        separatorBuilder:
            (_, __) => const SizedBox(width: BaakasSizes.spaceBtwItems),
        itemBuilder: (_, __) {
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              BaakasShimmerEffect(width: 55, height: 55, radius: 55),
              SizedBox(height: BaakasSizes.spaceBtwItems / 2),

              /// Text
              BaakasShimmerEffect(width: 55, height: 8),
            ],
          );
        },
      ),
    );
  }
}
