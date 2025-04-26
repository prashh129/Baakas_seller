import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/order_controller.dart';
import './order_details_screen.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Current'),
              Tab(text: 'Pending'),
              Tab(text: 'Shipped'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _OrderList(status: 'current'),
            _OrderList(status: 'pending'),
            _OrderList(status: 'shipped'),
            _OrderList(status: 'cancelled'),
          ],
        ),
      ),
    );
  }
}

class _OrderList extends StatelessWidget {
  final String status;
  const _OrderList({required this.status});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderController>();

    return Obx(() {
      final orders = controller.getOrdersByStatus(status);
      if (orders.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Iconsax.box, size: 50, color: BaakasColors.grey),
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              Text(
                'No $status orders',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
        itemCount: orders.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final order = orders[index];
          return ListTile(
            title: Text('Order #${order.id}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${order.items.length} items - \$${order.total}'),
                Text('Payment: ${order.paymentStatus}'),
              ],
            ),
            trailing: _buildActionButtons(context, order, controller),
            onTap: () => Get.to(() => OrderDetailsScreen(order: order)),
          );
        },
      );
    });
  }

  Widget _buildActionButtons(
    BuildContext context,
    OrderModel order,
    OrderController controller,
  ) {
    if (status == 'pending') {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(
              Iconsax.tick_circle,
              color: BaakasColors.primaryColor,
            ),
            onPressed: () => controller.acceptOrder(order.id),
          ),
          IconButton(
            icon: const Icon(Iconsax.close_circle, color: BaakasColors.error),
            onPressed: () => controller.cancelOrder(order.id),
          ),
        ],
      );
    } else if (status == 'current') {
      return IconButton(
        icon: const Icon(Iconsax.truck, color: BaakasColors.primaryColor),
        onPressed: () => controller.markAsShipped(order.id),
      );
    }
    return const SizedBox.shrink();
  }
}
