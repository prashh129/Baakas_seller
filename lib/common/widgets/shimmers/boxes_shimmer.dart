import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import 'shimmer.dart';

class BaakasBoxesShimmer extends StatelessWidget {
  const BaakasBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: BaakasShimmerEffect(width: 150, height: 110)),
            SizedBox(width: BaakasSizes.spaceBtwItems),
            Expanded(child: BaakasShimmerEffect(width: 150, height: 110)),
            SizedBox(width: BaakasSizes.spaceBtwItems),
            Expanded(child: BaakasShimmerEffect(width: 150, height: 110)),
          ],
        )
      ],
    );
  }
}
