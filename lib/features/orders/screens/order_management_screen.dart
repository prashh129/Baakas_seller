import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_controller.dart';
import '../widgets/order_filter_bar.dart';
import '../widgets/order_search_bar.dart';
import '../widgets/order_list.dart';
import 'package:baakas_seller/utils/constants/colors.dart';
import 'package:baakas_seller/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:baakas_seller/utils/constants/sizes.dart';
import 'package:baakas_seller/common/widgets/appbar/appbar.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> with SingleTickerProviderStateMixin {
  final OrderController controller = Get.put(OrderController());
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        switch (_tabController.index) {
          case 0:
            controller.filterOrders('all');
            break;
          case 1:
            controller.filterOrders('pending');
            break;
          case 2:
            controller.filterOrders('processing');
            break;
          case 3:
            controller.filterOrders('shipped');
            break;
          case 4:
            controller.filterOrders('canceled');
            break;
        }
      }
    });
    controller.fetchOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: isDark ? Colors.grey[300] : Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(bool isDark, String status) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              BaakasColors.primaryColor,
            ),
          ),
        );
      }

      final orders = status == 'all' 
          ? controller.orders 
          : controller.orders.where((order) => order.status.toLowerCase() == status).toList();

      if (orders.isEmpty) {
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
                  _getStatusIcon(status),
                  size: 48,
                  color: isDark ? Colors.grey[600] : Colors.grey[400],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'No ${status == 'all' ? '' : status} orders found',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _getEmptyStateMessage(status),
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
          orders: orders,
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
    });
  }

  String _getEmptyStateMessage(String status) {
    switch (status.toLowerCase()) {
      case 'all':
        return 'No orders have been placed yet';
      case 'pending':
        return 'No pending orders at the moment';
      case 'processing':
        return 'No orders are currently being processed';
      case 'shipped':
        return 'No orders have been shipped yet';
      case 'canceled':
        return 'No cancelled orders found';
      default:
        return 'New orders will appear here';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = BaakasHelperFunctions.isDarkMode(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.grey[100],
      appBar: AppBar(
        backgroundColor: BaakasColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: BaakasColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Order Management',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: BaakasColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.refresh, color: BaakasColors.white),
            onPressed: () => controller.fetchOrders(),
            tooltip: 'Refresh Orders',
          ),
        ],
      ),
      body: Column(
        children: [
          // Order Statistics Cards
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: BaakasColors.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Pending',
                    controller.pendingOrders.length.toString(),
                    Iconsax.timer_1,
                    Colors.orange,
                    isDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Processing',
                    controller.processingOrders.length.toString(),
                    Iconsax.box_1,
                    Colors.blue,
                    isDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Delivered',
                    controller.deliveredOrders.length.toString(),
                    Iconsax.verify,
                    Colors.green,
                    isDark,
                  ),
                ),
              ],
            ),
          ),

          // Tabs
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: BaakasColors.primaryColor,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: BaakasColors.primaryColor,
              unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey[600],
              isScrollable: true,
              padding: EdgeInsets.zero,
              labelPadding: const EdgeInsets.symmetric(horizontal: 16),
              tabAlignment: TabAlignment.start,
              tabs: [
                Tab(
                  height: 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Iconsax.box, size: 20),
                      const SizedBox(width: 8),
                      const Text('All'),
                    ],
                  ),
                ),
                Tab(
                  height: 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Iconsax.timer_1, size: 20),
                      const SizedBox(width: 8),
                      const Text('Pending'),
                    ],
                  ),
                ),
                Tab(
                  height: 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Iconsax.box_1, size: 20),
                      const SizedBox(width: 8),
                      const Text('Processing'),
                    ],
                  ),
                ),
                Tab(
                  height: 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Iconsax.truck, size: 20),
                      const SizedBox(width: 8),
                      const Text('Shipped'),
                    ],
                  ),
                ),
                Tab(
                  height: 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Iconsax.close_circle, size: 20),
                      const SizedBox(width: 8),
                      const Text('Cancelled'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Search Bar
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: OrderSearchBar(
              onSearch: controller.searchOrders,
              isDark: isDark,
            ),
          ),

          // Orders List with TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrderList(isDark, 'all'),
                _buildOrderList(isDark, 'pending'),
                _buildOrderList(isDark, 'processing'),
                _buildOrderList(isDark, 'shipped'),
                _buildOrderList(isDark, 'canceled'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
