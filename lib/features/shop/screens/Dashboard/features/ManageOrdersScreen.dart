import 'package:baakas_seller/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:baakas_seller/features/orders/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../../common/widgets/custom_containers/primary_container.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';


class ManageOrdersScreen extends StatefulWidget {
  const ManageOrdersScreen({super.key});

  @override
  State<ManageOrdersScreen> createState() => _ManageOrdersScreenState();
}

class _ManageOrdersScreenState extends State<ManageOrdersScreen> {
  final controller = Get.put(OrderController());
  final searchController = TextEditingController();
  String selectedStatus = 'all';
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );

  @override
  void initState() {
    super.initState();
    controller.fetchOrders();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Filter Orders',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              
              // Status Filter
              DropdownButtonFormField<String>(
                value: selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  prefixIcon: Icon(Iconsax.status_up),
                ),
                items: [
                  'all',
                  'pending',
                  'processing',
                  'shipped',
                  'delivered',
                  'cancelled'
                ].map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status.toUpperCase()),
                )).toList(),
                onChanged: (value) {
                  setState(() => selectedStatus = value!);
                },
              ),
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              
              // Date Range Filter
              ListTile(
                leading: const Icon(Iconsax.calendar),
                title: Text(
                  'Date Range: ${dateRange.start.toString().split(' ')[0]} - ${dateRange.end.toString().split(' ')[0]}',
                ),
                onTap: () async {
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                    initialDateRange: dateRange,
                  );
                  if (picked != null) {
                    setState(() => dateRange = picked);
                  }
                },
              ),
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              
              // Apply Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = BaakasHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: BaakasAppBar(
        title: Text(
          'Manage Orders',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.filter),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          BaakasSearchContainer(
            text: 'Search orders...',
            icon: Iconsax.search_normal,
            showBackground: true,
            showBoarder: true,
            onTap: () {
              // Handle search tap
            },
          ),

          // Orders List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.orders.isEmpty) {
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
                        'Orders will appear here when customers place them',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey[500] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Apply filters
              var filteredOrders = controller.orders.where((order) {
                final matchesSearch = order.id
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase());
                final matchesStatus = selectedStatus == 'all' ||
                    order.status.toLowerCase() == selectedStatus.toLowerCase();
                final matchesDate = order.orderDate.isAfter(dateRange.start) &&
                    order.orderDate.isBefore(dateRange.end.add(const Duration(days: 1)));
                return matchesSearch && matchesStatus && matchesDate;
              }).toList();

              return ListView.separated(
                padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
                itemCount: filteredOrders.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: BaakasSizes.spaceBtwItems),
                itemBuilder: (_, index) {
                  final order = filteredOrders[index];
                  return BaakasPrimaryContainer(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _getStatusColor(order.status),
                        child: const Icon(
                          Iconsax.box,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        'Order #${order.id}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status: ${order.status.toUpperCase()}',
                            style: TextStyle(
                              color: _getStatusColor(order.status),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Date: ${order.orderDate.toString().split(' ')[0]}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Iconsax.arrow_right_3),
                        onPressed: () {
                          // Navigate to order details
                        },
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
} 