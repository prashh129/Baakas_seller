import 'package:flutter/material.dart';
import 'package:baakas_seller/utils/constants/colors.dart';
import 'package:baakas_seller/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
import '../models/order.dart';

class OrderList extends StatelessWidget {
  final List<Order> orders;
  final Function(String, String) onStatusUpdate;
  final Function(String) onViewDetails;
  final bool isDark;

  const OrderList({
    super.key,
    required this.orders,
    required this.onStatusUpdate,
    required this.onViewDetails,
    required this.isDark,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Iconsax.timer_1;
      case 'processing':
        return Iconsax.box_1;
      case 'shipped':
        return Iconsax.truck;
      case 'delivered':
        return Iconsax.verify;
      case 'canceled':
        return Iconsax.close_circle;
      default:
        return Iconsax.box;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(BaakasSizes.md),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: const EdgeInsets.only(bottom: BaakasSizes.md),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
              width: 1,
            ),
          ),
          child: InkWell(
            onTap: () => onViewDetails(order.id),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(BaakasSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Header
                  Row(
                    children: [
                      // Order Status Icon
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _getStatusColor(order.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _getStatusIcon(order.status),
                          color: _getStatusColor(order.status),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: BaakasSizes.sm),
                      // Order Number and Date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order #${order.orderNumber}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              'Placed on ${_formatDate(order.orderDate)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Status Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: BaakasSizes.sm,
                          vertical: BaakasSizes.xs,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(order.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          order.status.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _getStatusColor(order.status),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: BaakasSizes.md),
                  // Order Details
                  Row(
                    children: [
                      // Customer Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.customerName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              order.customerEmail,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Total Amount
                      Text(
                        '\$${order.total.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: BaakasColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: BaakasSizes.md),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // View Details Button
                      TextButton.icon(
                        onPressed: () => onViewDetails(order.id),
                        icon: Icon(
                          Iconsax.eye,
                          size: 18,
                          color: BaakasColors.primaryColor,
                        ),
                        label: Text(
                          'View Details',
                          style: TextStyle(
                            color: BaakasColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: BaakasSizes.sm),
                      // Status Update Menu
                      PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_vert,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                        color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
                        onSelected: (status) => onStatusUpdate(order.id, status),
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            value: 'pending',
                            child: Row(
                              children: [
                                const Icon(Iconsax.timer_1, color: Colors.orange),
                                const SizedBox(width: 8),
                                Text(
                                  'Mark as Pending',
                                  style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'processing',
                            child: Row(
                              children: [
                                const Icon(Iconsax.box_1, color: Colors.blue),
                                const SizedBox(width: 8),
                                Text(
                                  'Mark as Processing',
                                  style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'shipped',
                            child: Row(
                              children: [
                                const Icon(Iconsax.truck, color: Colors.purple),
                                const SizedBox(width: 8),
                                Text(
                                  'Mark as Shipped',
                                  style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delivered',
                            child: Row(
                              children: [
                                const Icon(Iconsax.verify, color: Colors.green),
                                const SizedBox(width: 8),
                                Text(
                                  'Mark as Delivered',
                                  style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'canceled',
                            child: Row(
                              children: [
                                const Icon(Iconsax.close_circle, color: Colors.red),
                                const SizedBox(width: 8),
                                Text(
                                  'Mark as Canceled',
                                  style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
