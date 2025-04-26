import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart' show PdfPageFormat;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final RxList<OrderModel> _orders = <OrderModel>[].obs;
  List<OrderModel> get orders => _orders;

  // Add a variable to track if a snackbar is currently showing
  bool _isSnackbarShowing = false;

  @override
  void onInit() {
    super.onInit();
    _loadOrders();
  }

  void _loadOrders() {
    if (FirebaseAuth.instance.currentUser == null) return;

    FirebaseFirestore.instance
        .collection('Sellers')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      _orders.value = snapshot.docs.map((doc) {
        final data = doc.data();
        return OrderModel(
          id: doc.id,
          status: data['status'] ?? 'pending',
          paymentStatus: data['paymentStatus'] ?? 'pending',
          total: (data['total'] ?? 0.0).toDouble(),
          buyerName: data['buyerName'] ?? '',
          buyerEmail: data['buyerEmail'] ?? '',
          buyerPhone: data['buyerPhone'] ?? '',
          shippingAddress: data['shippingAddress'] ?? '',
          items: (data['items'] as List<dynamic>?)?.map((item) => OrderItem(
            name: item['name'] ?? '',
            price: (item['price'] ?? 0.0).toDouble(),
            quantity: item['quantity'] ?? 0,
            imageUrl: item['imageUrl'] ?? '',
          )).toList() ?? [],
          trackingNumber: data['trackingNumber'],
        );
      }).toList();
    });
  }

  List<OrderModel> getOrdersByStatus(String status) {
    return _orders.where((order) => order.status == status).toList();
  }

  // Helper method to show snackbar safely
  void _showSnackbar(String title, String message) {
    if (_isSnackbarShowing) {
      Get.closeAllSnackbars();
    }
    _isSnackbarShowing = true;
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      onTap: null,
      isDismissible: true,
    ).future.whenComplete(() {
      _isSnackbarShowing = false;
    });
  }

  Future<void> acceptOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Sellers')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('orders')
          .doc(orderId)
          .update({'status': 'current'});
      
      _showSnackbar('Success', 'Order accepted successfully');
    } catch (e) {
      _showSnackbar('Error', 'Failed to accept order');
    }
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Sellers')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('orders')
          .doc(orderId)
          .update({'status': 'cancelled'});
      
      _showSnackbar('Success', 'Order cancelled successfully');
    } catch (e) {
      _showSnackbar('Error', 'Failed to cancel order');
    }
  }

  Future<void> markAsShipped(String orderId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Sellers')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('orders')
          .doc(orderId)
          .update({
            'status': 'shipped',
            'trackingNumber': 'TRK${DateTime.now().millisecondsSinceEpoch}'
          });
      
      _showSnackbar('Success', 'Order marked as shipped');
    } catch (e) {
      _showSnackbar('Error', 'Failed to mark order as shipped');
    }
  }

  Future<void> printInvoice(String orderId) async {
    try {
      final order = _orders.firstWhere((order) => order.id == orderId);
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'INVOICE',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text('Order #${order.id}'),
                pw.Text('Date: ${DateTime.now().toString().split(' ')[0]}'),
                pw.SizedBox(height: 20),
                pw.Text('Bill To:'),
                pw.Text(order.buyerName),
                pw.Text(order.buyerEmail),
                pw.Text(order.buyerPhone),
                pw.Text(order.shippingAddress),
                pw.SizedBox(height: 20),
                pw.Table.fromTextArray(
                  headers: ['Item', 'Quantity', 'Price', 'Total'],
                  data:
                      order.items
                          .map(
                            (item) => [
                              item.name,
                              item.quantity.toString(),
                              '\$${item.price}',
                              '\$${item.price * item.quantity}',
                            ],
                          )
                          .toList(),
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text(
                      'Total: \$${order.total}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );

      await Printing.layoutPdf(onLayout: (format) => pdf.save());
      _showSnackbar('Success', 'Invoice generated successfully');
    } catch (e) {
      _showSnackbar('Error', 'Failed to generate invoice');
    }
  }
}

class OrderModel {
  final String id;
  final String status;
  final String paymentStatus;
  final double total;
  final String buyerName;
  final String buyerEmail;
  final String buyerPhone;
  final String shippingAddress;
  final List<OrderItem> items;
  final String? trackingNumber;

  OrderModel({
    required this.id,
    required this.status,
    required this.paymentStatus,
    required this.total,
    required this.buyerName,
    required this.buyerEmail,
    required this.buyerPhone,
    required this.shippingAddress,
    required this.items,
    this.trackingNumber,
  });

  OrderModel copyWith({String? status, String? trackingNumber}) {
    return OrderModel(
      id: id,
      status: status ?? this.status,
      paymentStatus: paymentStatus,
      total: total,
      buyerName: buyerName,
      buyerEmail: buyerEmail,
      buyerPhone: buyerPhone,
      shippingAddress: shippingAddress,
      items: items,
      trackingNumber: trackingNumber ?? this.trackingNumber,
    );
  }
}

class OrderItem {
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;

  OrderItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  bool get isAssetImage => imageUrl.startsWith('assets/');
}
