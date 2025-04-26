import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/sizes.dart';

class RevenueCard extends StatelessWidget {
  const RevenueCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Revenue Analysis',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: BaakasSizes.spaceBtwItems),
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Revenue by Category',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed('/analytics'),
                      child: const Text('View Details'),
                    ),
                  ],
                ),
                const SizedBox(height: BaakasSizes.spaceBtwItems),
                Container(
                  height: 150,
                  color: Colors.grey[200],
                  child: const Center(child: Text('Revenue Chart Placeholder')),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
