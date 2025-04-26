import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_controller.dart';
import '../widgets/order_filter_bar.dart';
import '../widgets/order_search_bar.dart';
import '../widgets/order_list.dart';
import 'package:baakas_seller/utils/constants/colors.dart';
import 'package:baakas_seller/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:baakas_seller/common/widgets/appbar/appbar.dart';

class OrderManagementScreen extends StatelessWidget {
  final OrderController controller = Get.put(OrderController());

  OrderManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = BaakasHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.grey[100],
      appBar: BaakasAppBar(
        title: Center(
          child: Text(
            'Order Management',
            style: Theme.of(context).textTheme.headlineSmall!.apply(
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Order Statistics Cards
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildStatCard(
                  context,
                  'Pending',
                  controller.pendingOrders.length.toString(),
                  Iconsax.timer,
                  BaakasColors.warning,
                  isDark,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  context,
                  'Processing',
                  controller.processingOrders.length.toString(),
                  Iconsax.box_1,
                  BaakasColors.primaryColor,
                  isDark,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  context,
                  'Delivered',
                  controller.deliveredOrders.length.toString(),
                  Iconsax.verify,
                  BaakasColors.success,
                  isDark,
                ),
              ],
            ),
          ),

          // Search and Filter Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                OrderSearchBar(
                  onSearch: controller.searchOrders,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),
                OrderFilterBar(
                  onFilterChanged: controller.filterOrders,
                  isDark: isDark,
                ),
              ],
            ),
          ),

          // Orders List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      BaakasColors.primaryColor,
                    ),
                  ),
                );
              }

              if (controller.filteredOrders.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[800] : Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Iconsax.box,
                          size: 48,
                          color: isDark ? Colors.grey[600] : Colors.grey[400],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No orders found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'New orders will appear here',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey[500] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => controller.fetchOrders(),
                color: BaakasColors.primaryColor,
                child: OrderList(
                  orders: controller.filteredOrders,
                  onStatusUpdate: controller.updateOrderStatus,
                  onViewDetails: (orderId) {
                    final order = controller.orders.firstWhere(
                      (o) => o.id == orderId,
                    );
                    Get.toNamed('/order-details', arguments: order);
                  },
                  isDark: isDark,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
    bool isDark,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
