import 'package:flutter/material.dart';
import '../models/order_model.dart';
import 'package:baakas_seller/utils/constants/colors.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${order.id}'),
        backgroundColor: BaakasColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard('Order Information', [
              _buildInfoRow('Status', order.status),
              _buildInfoRow('Order Date', order.orderDate),
              _buildInfoRow(
                'Total Amount',
                '\$${order.total.toStringAsFixed(2)}',
              ),
            ]),
            const SizedBox(height: 16),
            _buildInfoCard('Customer Information', [
              _buildInfoRow('Name', order.customerName),
              _buildInfoRow('Email', order.customerEmail),
              _buildInfoRow('Phone', order.customerPhone),
            ]),
            const SizedBox(height: 16),
            _buildInfoCard('Shipping Address', [Text(order.shippingAddress)]),
            const SizedBox(height: 16),
            _buildInfoCard(
              'Order Items',
              order.items
                  .map(
                    (item) => ListTile(
                      title: Text(item.name),
                      subtitle: Text('Quantity: ${item.quantity}'),
                      trailing: Text('\$${item.price.toStringAsFixed(2)}'),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle refund request
                },
                child: const Text('Process Refund'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle return request
                },
                child: const Text('Process Return'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
