import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/colors.dart';

class MetricsGrid extends StatelessWidget {
  const MetricsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Analytics Overview',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: BaakasSizes.spaceBtwItems),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: BaakasSizes.gridViewSpacing,
          crossAxisSpacing: BaakasSizes.gridViewSpacing,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildMetricCard(
              'Total Sales',
              'Rs 45,678',
              '+12.5%',
              Iconsax.money_tick,
              BaakasColors.primaryColor,
              true,
            ),
            _buildMetricCard(
              'Orders',
              '156',
              '+8.2%',
              Iconsax.shopping_cart,
              Colors.blue,
              true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String growth,
    IconData icon,
    Color color,
    bool isPositive,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(BaakasSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: BaakasSizes.sm,
                    vertical: BaakasSizes.xs,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isPositive
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      BaakasSizes.borderRadiusSm,
                    ),
                  ),
                  child: Text(
                    growth,
                    style: TextStyle(
                      color: isPositive ? Colors.green : Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: BaakasSizes.spaceBtwItems),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: BaakasSizes.xs),
            Text(
              title,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
