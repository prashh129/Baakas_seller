// import 'package:flutter/material.dart';
// import 'package:baakas_seller/common/widgets/appbar/appbar.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import '../../../../common/widgets/custom_containers/primary_container.dart';
// import '../../../../utils/constants/sizes.dart';
// import '../../controllers/order_controller.dart';
// import 'order_details_screen.dart';

// class AllOrdersScreen extends StatelessWidget {
//   const AllOrdersScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Initialize the controller
//     final controller = Get.put(OrderController());

//     return Scaffold(
//       appBar: BaakasAppBar(
//         title: Text(
//           'All Orders',
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//         showBackArrow: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
//           child: Obx(
//             () => Column(
//               children:
//                   controller.orders.map((order) {
//                     return Padding(
//                       padding: const EdgeInsets.only(
//                         bottom: BaakasSizes.spaceBtwItems,
//                       ),
//                       child: BaakasPrimaryContainer(
//                         padding: const EdgeInsets.all(BaakasSizes.md),
//                         child: InkWell(
//                           onTap:
//                               () => Get.to(
//                                 () => OrderDetailsScreen(order: order),
//                               ),
//                           child: Row(
//                             children: [
//                               // Order Icon with Status Color
//                               Container(
//                                 width: 48,
//                                 height: 48,
//                                 padding: const EdgeInsets.all(BaakasSizes.sm),
//                                 decoration: BoxDecoration(
//                                   color: _getStatusColor(
//                                     order.status,
//                                   ).withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(
//                                     BaakasSizes.sm,
//                                   ),
//                                 ),
//                                 child: Icon(
//                                   order.items.isNotEmpty &&
//                                           order.items.first.imageUrl.startsWith(
//                                             'http',
//                                           )
//                                       ? Iconsax.shopping_cart
//                                       : Iconsax.box,
//                                   color: _getStatusColor(order.status),
//                                 ),
//                               ),

//                               const SizedBox(width: BaakasSizes.spaceBtwItems),

//                               // Order Details
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Order Number
//                                     Text(
//                                       'Order #${order.id}',
//                                       style:
//                                           Theme.of(
//                                             context,
//                                           ).textTheme.titleMedium,
//                                     ),

//                                     const SizedBox(height: BaakasSizes.xs),

//                                     // Price and Items Count
//                                     Text(
//                                       '\Rs ${order.total} - ${order.items.length} items',
//                                       style:
//                                           Theme.of(
//                                             context,
//                                           ).textTheme.bodyMedium,
//                                     ),

//                                     const SizedBox(height: BaakasSizes.xs),

//                                     // Status
//                                     Text(
//                                       order.status,
//                                       style: Theme.of(
//                                         context,
//                                       ).textTheme.labelMedium?.copyWith(
//                                         color: _getStatusColor(order.status),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),

//                               // Arrow Icon
//                               Icon(
//                                 Iconsax.arrow_right_3,
//                                 size: 18,
//                                 color:
//                                     Theme.of(
//                                       context,
//                                     ).textTheme.bodyMedium?.color,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'pending':
//         return Colors.orange;
//       case 'current':
//         return Colors.blue;
//       case 'shipped':
//         return Colors.green;
//       case 'cancelled':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:baakas_seller/common/widgets/appbar/appbar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/custom_containers/primary_container.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/order_controller.dart';
import 'order_details_screen.dart';

class AllOrdersScreen extends StatelessWidget {
  const AllOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(OrderController());

    return Scaffold(
      appBar: BaakasAppBar(
        title: Text(
          'All Orders',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 20, // Reduced font size for "All Orders"
          ),
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
          child: Obx(
            () => Column(
              children:
                  controller.orders.map((order) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom:
                            BaakasSizes.spaceBtwItems /
                            1.5, // Reduced bottom padding
                      ),
                      child: BaakasPrimaryContainer(
                        padding: const EdgeInsets.all(
                          BaakasSizes.sm,
                        ), // Reduced padding
                        child: InkWell(
                          onTap:
                              () => Get.to(
                                () => OrderDetailsScreen(order: order),
                              ),
                          child: Row(
                            children: [
                              // Order Icon with Status Color
                              Container(
                                width: 40, // Reduced width for icon container
                                height: 40, // Reduced height for icon container
                                padding: const EdgeInsets.all(
                                  BaakasSizes.xs,
                                ), // Smaller padding
                                decoration: BoxDecoration(
                                  color: _getStatusColor(
                                    order.status,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(
                                    BaakasSizes.sm,
                                  ),
                                ),
                                child: Icon(
                                  order.items.isNotEmpty &&
                                          order.items.first.imageUrl.startsWith(
                                            'http',
                                          )
                                      ? Iconsax.shopping_cart
                                      : Iconsax.box,
                                  color: _getStatusColor(order.status),
                                  size: 20, // Reduced icon size
                                ),
                              ),
                              const SizedBox(
                                width: BaakasSizes.spaceBtwItems / 2,
                              ), // Smaller spacing
                              // Order Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Order Number
                                    Text(
                                      'Order #${order.id}',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.copyWith(
                                        fontSize: 14, // Smaller font size
                                      ),
                                    ),
                                    const SizedBox(height: BaakasSizes.xs),

                                    // Price and Items Count
                                    Text(
                                      'Rs ${order.total} - ${order.items.length} items',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall?.copyWith(
                                        fontSize: 12, // Smaller font size
                                      ),
                                    ),
                                    const SizedBox(height: BaakasSizes.xs),

                                    // Status
                                    Text(
                                      order.status,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelSmall?.copyWith(
                                        color: _getStatusColor(order.status),
                                        fontSize:
                                            12, // Smaller font size for status
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Arrow Icon
                              Icon(
                                Iconsax.arrow_right_3,
                                size: 16, // Smaller arrow icon size
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'current':
        return Colors.blue;
      case 'shipped':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
