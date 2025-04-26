import 'package:baakas_seller/features/shop/screens/products_seller/product_model.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';

class ProductListItem extends StatelessWidget {
  final ProductModelSeller product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<bool> onToggleStatus;

  const ProductListItem({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleStatus,
  });

  Widget _buildProductImage(BuildContext context, String imageUrl) {
    final theme = Theme.of(context);

    if (imageUrl.isEmpty) {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.image_not_supported,
          size: 30,
          color: theme.colorScheme.onSurface.withOpacity(0.5),
        ),
      );
    }

    if (imageUrl.startsWith('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.broken_image,
                size: 30,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            );
          },
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.broken_image,
                size: 30,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isActive = product.status == 'Active';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
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
                  Text(product.title, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "₹${product.price?.toStringAsFixed(2) ?? '0.00'}",
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: BaakasColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (product.discountPrice != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          "₹${product.discountPrice?.toStringAsFixed(2)}",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: theme.colorScheme.onSurface.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "Stock: ${product.stock}",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive
                              ? BaakasColors.primaryColor
                              : theme.colorScheme.onSurface.withOpacity(0.4),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        product.status,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isActive
                              ? BaakasColors.primaryColor
                              : theme.colorScheme.onSurface.withOpacity(0.4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // More Options Button
            IconButton(
              icon: Icon(Icons.more_vert, color: theme.colorScheme.onSurface),
              onPressed: onEdit,
            ),
          ],
        ),
      ),
    );
  }
}
