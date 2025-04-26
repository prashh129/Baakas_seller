import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String status;
  final double total;
  final String orderDate;
  final String shippingAddress;
  final List<OrderItem> items;

  OrderModel({
    required this.id,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.status,
    required this.total,
    required this.orderDate,
    required this.shippingAddress,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'customerPhone': customerPhone,
      'status': status,
      'total': total,
      'orderDate': orderDate,
      'shippingAddress': shippingAddress,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return OrderModel(
      id: snap.id,
      customerName: data['customerName'] ?? '',
      customerEmail: data['customerEmail'] ?? '',
      customerPhone: data['customerPhone'] ?? '',
      status: data['status'] ?? 'pending',
      total: (data['total'] ?? 0.0).toDouble(),
      orderDate: data['orderDate'] ?? '',
      shippingAddress: data['shippingAddress'] ?? '',
      items:
          (data['items'] as List<dynamic>?)
              ?.map((item) => OrderItem.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class OrderItem {
  final String name;
  final int quantity;
  final double price;
  final String? imageUrl;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0.0).toDouble(),
      imageUrl: json['imageUrl'],
    );
  }
}
