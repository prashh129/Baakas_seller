import 'package:flutter/material.dart';
import 'package:baakas_seller/common/widgets/appbar/appbar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/custom_containers/primary_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/order_controller.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderController>();
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: BaakasAppBar(
        title: Text(
          'Order Details',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
          child: Column(
            children: [
              // Order Status Section
              BaakasPrimaryContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: BaakasSizes.sm,
                            vertical: BaakasSizes.xs,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(order.status),
                            borderRadius: BorderRadius.circular(BaakasSizes.sm),
                          ),
                          child: Text(
                            order.status.toUpperCase(),
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: BaakasSizes.spaceBtwItems),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: BaakasSizes.sm,
                            vertical: BaakasSizes.xs,
                          ),
                          decoration: BoxDecoration(
                            color:
                                order.paymentStatus == 'paid'
                                    ? Colors.green
                                    : Colors.orange,
                            borderRadius: BorderRadius.circular(BaakasSizes.sm),
                          ),
                          child: Text(
                            order.paymentStatus.toUpperCase(),
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    if (order.trackingNumber != null) ...[
                      const SizedBox(height: BaakasSizes.spaceBtwItems),
                      Row(
                        children: [
                          const Icon(Iconsax.truck, size: 18),
                          const SizedBox(width: BaakasSizes.xs),
                          Text(
                            'Tracking Number: ',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            order.trackingNumber!,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: BaakasColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: BaakasSizes.spaceBtwSections),

              // Buyer Information Section
              BaakasPrimaryContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buyer Information',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: BaakasSizes.spaceBtwItems),
                    _buildInfoRow(
                      context,
                      Iconsax.user,
                      'Name',
                      order.buyerName,
                    ),
                    _buildInfoRow(
                      context,
                      Iconsax.message,
                      'Email',
                      order.buyerEmail,
                    ),
                    _buildInfoRow(
                      context,
                      Iconsax.call,
                      'Phone',
                      order.buyerPhone,
                    ),
                    const SizedBox(height: BaakasSizes.spaceBtwItems),
                    _buildInfoRow(
                      context,
                      Iconsax.location,
                      'Shipping Address',
                      order.shippingAddress,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: BaakasSizes.spaceBtwSections),

              // Order Items Section
              BaakasPrimaryContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Items',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: BaakasSizes.spaceBtwItems),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: order.items.length,
                      separatorBuilder:
                          (_, __) => Divider(
                            color:
                                dark
                                    ? BaakasColors.darkGrey
                                    : BaakasColors.grey,
                          ),
                      itemBuilder: (context, index) {
                        final item = order.items[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(BaakasSizes.sm),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: dark ? Colors.black : Colors.white,
                                borderRadius: BorderRadius.circular(
                                  BaakasSizes.sm,
                                ),
                              ),
                              child:
                                  item.imageUrl.startsWith('http')
                                      ? Image.network(
                                        item.imageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Container(
                                            color:
                                                dark
                                                    ? Colors.black
                                                    : Colors.grey[200],
                                            child: Icon(
                                              Iconsax.image,
                                              color:
                                                  dark
                                                      ? Colors.white54
                                                      : Colors.black54,
                                            ),
                                          );
                                        },
                                        loadingBuilder: (
                                          context,
                                          child,
                                          loadingProgress,
                                        ) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Container(
                                            color:
                                                dark
                                                    ? Colors.black
                                                    : Colors.grey[200],
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                value:
                                                    loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                      : Image.asset(
                                        item.imageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Container(
                                            color:
                                                dark
                                                    ? Colors.black
                                                    : Colors.grey[200],
                                            child: Icon(
                                              Iconsax.image,
                                              color:
                                                  dark
                                                      ? Colors.white54
                                                      : Colors.black54,
                                            ),
                                          );
                                        },
                                      ),
                            ),
                          ),
                          title: Text(
                            item.name,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          subtitle: Text(
                            'Quantity: ${item.quantity}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: Text(
                            'Rs ${item.price}',
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              color: BaakasColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: BaakasSizes.spaceBtwItems),
                    const Divider(height: BaakasSizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Rs ${order.total}',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: BaakasColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BaakasSizes.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: BaakasSizes.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall),
                Text(value, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
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
