import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:logger/logger.dart';
import '../models/order.dart';

class OrderService {
  final firestore.FirebaseFirestore _firestore =
      firestore.FirebaseFirestore.instance;
  final String _collection = 'orders';
  final _logger = Logger();

  Future<List<Order>> getOrders() async {
    try {
      final firestore.QuerySnapshot snapshot =
          await _firestore
              .collection(_collection)
              .orderBy('orderDate', descending: true)
              .get();

      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    } catch (e) {
      _logger.e('Error fetching orders: $e');
      return [];
    }
  }

  Future<bool> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await _firestore.collection(_collection).doc(orderId).update({
        'status': newStatus,
      });
      return true;
    } catch (e) {
      _logger.e('Error updating order status: $e');
      return false;
    }
  }

  Future<List<Order>> searchOrders(String query) async {
    try {
      final firestore.QuerySnapshot snapshot =
          await _firestore
              .collection(_collection)
              .where('customerName', isGreaterThanOrEqualTo: query)
              .where('customerName', isLessThan: '${query}z')
              .get();

      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    } catch (e) {
      _logger.e('Error searching orders: $e');
      return [];
    }
  }

  Future<List<Order>> filterOrdersByStatus(String status) async {
    try {
      final firestore.QuerySnapshot snapshot =
          await _firestore
              .collection(_collection)
              .where('status', isEqualTo: status)
              .orderBy('orderDate', descending: true)
              .get();

      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    } catch (e) {
      _logger.e('Error filtering orders: $e');
      return [];
    }
  }

  Future<bool> processRefund(String orderId) async {
    try {
      await _firestore.collection(_collection).doc(orderId).update({
        'status': 'refunded',
        'refundedAt': firestore.FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      _logger.e('Error processing refund: $e');
      return false;
    }
  }

  Future<bool> processReturn(String orderId) async {
    try {
      await _firestore.collection(_collection).doc(orderId).update({
        'status': 'returned',
        'returnedAt': firestore.FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      _logger.e('Error processing return: $e');
      return false;
    }
  }
}
