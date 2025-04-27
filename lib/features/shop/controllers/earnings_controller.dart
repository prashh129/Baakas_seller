import 'package:baakas_seller/features/orders/models/order_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import '../../../utils/constants/enums.dart';

class EarningsController extends GetxController {
  static EarningsController get instance => Get.find();
  final _logger = Logger();

  final RxList<OrderModel> _orders = <OrderModel>[].obs;
  final RxDouble _totalEarnings = 0.0.obs;
  final RxDouble _pendingEarnings = 0.0.obs;
  final RxList<Map<String, dynamic>> _weeklyEarnings = <Map<String, dynamic>>[].obs;

  List<OrderModel> get orders => _orders;
  double get totalEarnings => _totalEarnings.value;
  double get pendingEarnings => _pendingEarnings.value;
  List<Map<String, dynamic>> get weeklyEarnings => _weeklyEarnings;

  @override
  void onInit() {
    super.onInit();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('orders')
          .orderBy('orderDate', descending: true)
          .get();

      _orders.value = snapshot.docs
          .map((doc) => OrderModel.fromSnapshot(doc))
          .toList();

      _calculateEarnings();
      _calculateWeeklyEarnings();
    } catch (e) {
      _logger.e('Error loading orders: $e');
    }
  }

  void _calculateEarnings() {
    double total = 0.0;
    double pending = 0.0;
    final now = DateTime.now();

    for (var order in _orders) {
      if (order.status == OrderStatus.delivered) {
        // Handle orderDate
        DateTime orderDate;
        try {
          if (order.orderDate is String) {
            orderDate = DateTime.parse(order.orderDate as String);
          } else {
            orderDate = order.orderDate as DateTime;
          }
        } catch (e) {
          _logger.w('Invalid orderDate format: ${order.orderDate}');
          continue;
        }
        
        final daysSinceDelivery = now.difference(orderDate).inDays;
        
        if (daysSinceDelivery >= 7) {
          // If order was delivered more than 7 days ago, add to total earnings
          total += order.total;
        } else {
          // If order was delivered less than 7 days ago, add to pending earnings
          pending += order.total;
        }
      }
    }

    _totalEarnings.value = total;
    _pendingEarnings.value = pending;
  }

  void _calculateWeeklyEarnings() {
    final now = DateTime.now();
    final startOfWeek = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1));
    
    // Create a list to store daily totals
    List<Map<String, dynamic>> dailyEarnings = [];
    
    // Initialize all days of the week with 0 earnings
    for (int i = 0; i < 7; i++) {
      final date = startOfWeek.add(Duration(days: i));
      dailyEarnings.add({
        'date': date,
        'amount': 0.0,
      });
    }

    // Calculate earnings for each day
    for (var order in _orders) {
      if (order.status == OrderStatus.delivered) {
        // Handle orderDate
        DateTime orderDate;
        try {
          if (order.orderDate is String) {
            orderDate = DateTime.parse(order.orderDate as String);
          } else {
            orderDate = order.orderDate as DateTime;
          }
        } catch (e) {
          _logger.w('Invalid orderDate format: ${order.orderDate}');
          continue;
        }
        
        final orderDayStart = DateTime(orderDate.year, orderDate.month, orderDate.day);
        
        // Find the corresponding day in our list
        final dayIndex = dailyEarnings.indexWhere((day) => 
          day['date'].year == orderDayStart.year &&
          day['date'].month == orderDayStart.month &&
          day['date'].day == orderDayStart.day
        );
        
        if (dayIndex != -1) {
          dailyEarnings[dayIndex]['amount'] = (dailyEarnings[dayIndex]['amount'] as double) + order.total;
        }
      }
    }

    _weeklyEarnings.value = dailyEarnings;
  }
} 