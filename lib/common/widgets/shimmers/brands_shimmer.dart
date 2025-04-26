import 'package:flutter/material.dart';
import '../layouts/grid_layout.dart';
import 'shimmer.dart';

class BaakasBrandsShimmer extends StatelessWidget {
  const BaakasBrandsShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return BaakasGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const BaakasShimmerEffect(width: 300, height: 80),
    );
  }
}
