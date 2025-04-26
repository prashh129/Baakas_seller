import 'package:flutter/material.dart';
import 'shimmer.dart';

import '../../../utils/constants/sizes.dart';

class BaakasListTileShimmer extends StatelessWidget {
  const BaakasListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            BaakasShimmerEffect(width: 50, height: 50, radius: 50),
            SizedBox(width: BaakasSizes.spaceBtwItems),
            Column(
              children: [
                BaakasShimmerEffect(width: 100, height: 15),
                SizedBox(height: BaakasSizes.spaceBtwItems / 2),
                BaakasShimmerEffect(width: 80, height: 12),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
