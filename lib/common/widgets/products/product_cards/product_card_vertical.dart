import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class BaakasProductCardVertical extends StatelessWidget {
  const BaakasProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BaakasSizes.sm),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(BaakasSizes.cardRadiusLg),
        boxShadow: [
          BoxShadow(
            color: BaakasColors.darkGrey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Column(
        children: [
          // Placeholder for product image, title, price, etc.
          Center(child: Text('Product Card')),
        ],
      ),
    );
  }
} 