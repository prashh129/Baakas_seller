import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final String orderNumber;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String status;
  final double total;
  final DateTime orderDate;
  final Map<String, dynamic> shippingAddress;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.orderNumber,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.status,
    required this.total,
    required this.orderDate,
    required this.shippingAddress,
    required this.items,
  });

  factory Order.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Order(
      id: doc.id,
      orderNumber: data['orderNumber'] ?? '',
      customerName: data['customerName'] ?? '',
      customerEmail: data['customerEmail'] ?? '',
      customerPhone: data['customerPhone'] ?? '',
      status: data['status'] ?? 'pending',
      total: (data['total'] ?? 0.0).toDouble(),
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      shippingAddress: Map<String, dynamic>.from(data['shippingAddress'] ?? {}),
      items:
          (data['items'] as List<dynamic>)
              .map((item) => OrderItem.fromMap(item as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderNumber': orderNumber,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'customerPhone': customerPhone,
      'status': status,
      'total': total,
      'orderDate': Timestamp.fromDate(orderDate),
      'shippingAddress': shippingAddress,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final int quantity;
  final double price;
  final String? variation;
  final Map<String, dynamic>? customization;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    this.variation,
    this.customization,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: (map['price'] ?? 0.0).toDouble(),
      variation: map['variation'],
      customization: map['customization'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'price': price,
      'variation': variation,
      'customization': customization,
    };
  }
}
