import 'package:baakas_seller/features/shop/screens/products_seller/product_model.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../utils/constants/enums.dart';
import 'package:get/get.dart';
import 'add_product_screen.dart';

class ProductListItem extends StatelessWidget {
  final ProductModelSeller product;
  final Function(String)? onStatusChanged;

  const ProductListItem({
    super.key,
    required this.product,
    this.onStatusChanged,
  });

  Future<bool> _isUserAdmin() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return false;

    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('Sellers')
          .doc(userId)
          .get();

      if (!userDoc.exists) return false;

      final userData = userDoc.data();
      if (userData == null) return false;

      final role = userData['role'] as String?;
      return role == AppRole.admin.name;
    } catch (e) {
      return false;
    }
  }

  Future<void> _updateProductStatus(BuildContext context, String newStatus, [String? rejectionReason]) async {
    final sellerId = FirebaseAuth.instance.currentUser?.uid;
    if (sellerId == null) return;

    // Check if user is admin
    final isAdmin = await _isUserAdmin();
    if (!isAdmin) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Only admins can approve or reject products'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('Sellers')
          .doc(sellerId)
          .collection('seller_products')
          .doc(product.id)
          .update({
        'status': newStatus,
        if (rejectionReason != null) 'rejectionReason': rejectionReason,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (onStatusChanged != null) {
        onStatusChanged!(newStatus);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating status: $e')),
        );
      }
    }
  }

  Future<void> _showRejectionDialog(BuildContext context) async {
    final reasonController = TextEditingController();
    
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Product'),
        content: TextField(
          controller: reasonController,
          decoration: const InputDecoration(
            labelText: 'Rejection Reason',
            hintText: 'Enter reason for rejection',
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (reasonController.text.isNotEmpty) {
                _updateProductStatus(context, 'rejected', reasonController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteProduct(BuildContext context) async {
    final sellerId = FirebaseAuth.instance.currentUser?.uid;
    if (sellerId == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('Sellers')
          .doc(sellerId)
          .collection('seller_products')
          .doc(product.id)
          .delete();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting product: $e')),
        );
      }
    }
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _deleteProduct(context);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _makeProductInactive(BuildContext context) async {
    final sellerId = FirebaseAuth.instance.currentUser?.uid;
    if (sellerId == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('Sellers')
          .doc(sellerId)
          .collection('seller_products')
          .doc(product.id)
          .update({
        'isActive': false,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product marked as inactive'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating product: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Row(
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _buildProductImage(context, product.images[0]),
                ),
                const SizedBox(width: 12),

                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Price: Rs ${product.price?.toStringAsFixed(2) ?? '0.00'}',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(product.status),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              product.status.toUpperCase(),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (product.status == 'pending') ...[
                            const SizedBox(width: 8),
                            FutureBuilder<bool>(
                              future: _isUserAdmin(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const SizedBox.shrink();
                                }
                                
                                final isAdmin = snapshot.data ?? false;
                                if (!isAdmin) return const SizedBox.shrink();

                                return Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.check_circle_outline, color: Colors.green),
                                      onPressed: () => _updateProductStatus(context, 'approved'),
                                      tooltip: 'Approve',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.cancel_outlined, color: Colors.red),
                                      onPressed: () => _showRejectionDialog(context),
                                      tooltip: 'Reject',
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ],
                      ),
                      if (product.rejectionReason != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Reason: ${product.rejectionReason}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (product.status == 'approved')
              Positioned(
                top: 0,
                right: 0,
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        Get.to(() => AddProductScreen(productToEdit: product));
                        break;
                      case 'delete':
                        _showDeleteConfirmationDialog(context);
                        break;
                      case 'inactive':
                        _makeProductInactive(context);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Colors.blue),
                          SizedBox(width: 8),
                          Text('Edit Product'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'inactive',
                      child: Row(
                        children: [
                          Icon(Icons.visibility_off, color: Colors.orange),
                          SizedBox(width: 8),
                          Text('Make Inactive'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete Product'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (product.status == 'pending')
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _showDeleteConfirmationDialog(context),
                  tooltip: 'Delete Product',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(BuildContext context, String imageUrl) {
    return Image.network(
      imageUrl,
      width: 80,
      height: 80,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 80,
          height: 80,
          color: Colors.grey[300],
          child: const Icon(Icons.image_not_supported),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
