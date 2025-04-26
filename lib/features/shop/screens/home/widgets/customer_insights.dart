import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';

class CustomerInsights extends StatelessWidget {
  const CustomerInsights({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Customers',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => Get.toNamed('/analytics'),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: BaakasSizes.spaceBtwItems),
        Card(
          elevation: 2,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Iconsax.user),
                ),
                title: Text('Customer ${index + 1}'),
                subtitle: Text('Orders: ${(10 - index * 2)}'),
                trailing: Text('₹${(1000 - index * 200)}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
