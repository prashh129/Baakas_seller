import 'package:get/get.dart';
import '../models/order.dart';
import '../services/order_service.dart';

class OrderController extends GetxController {
  final OrderService _orderService = OrderService();
  final RxList<Order> orders = <Order>[].obs;
  final RxList<Order> filteredOrders = <Order>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  // Getters for order statistics
  List<Order> get pendingOrders =>
      orders.where((order) => order.status == 'pending').toList();
  List<Order> get processingOrders =>
      orders.where((order) => order.status == 'processing').toList();
  List<Order> get deliveredOrders =>
      orders.where((order) => order.status == 'delivered').toList();

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      final fetchedOrders = await _orderService.getOrders();
      orders.value = fetchedOrders;
      filteredOrders.value = fetchedOrders;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch orders',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void searchOrders(String query) {
    if (query.isEmpty) {
      filteredOrders.value = orders;
      return;
    }

    filteredOrders.value =
        orders.where((order) {
          final orderNumber = order.orderNumber.toLowerCase();
          final customerName = order.customerName.toLowerCase();
          final searchLower = query.toLowerCase();

          return orderNumber.contains(searchLower) ||
              customerName.contains(searchLower);
        }).toList();
  }

  void filterOrders(String status) {
    if (status.isEmpty || status == 'all') {
      filteredOrders.value = orders;
      return;
    }

    filteredOrders.value =
        orders
            .where(
              (order) => order.status.toLowerCase() == status.toLowerCase(),
            )
            .toList();
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await _orderService.updateOrderStatus(orderId, newStatus);
      await fetchOrders(); // Refresh orders after update
      Get.snackbar(
        'Success',
        'Order status updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update order status',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> processRefund(String orderId) async {
    try {
      // Implement your refund logic here
      await _orderService.processRefund(orderId);
      await fetchOrders();
      Get.snackbar('Success', 'Refund processed successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to process refund: $e');
    }
  }

  Future<void> processReturn(String orderId) async {
    try {
      // Implement your return logic here
      await _orderService.processReturn(orderId);
      await fetchOrders();
      Get.snackbar('Success', 'Return processed successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to process return: $e');
    }
  }
}
