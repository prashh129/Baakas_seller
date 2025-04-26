import 'package:baakas_seller/features/shop/screens/products_seller/widgets/add_product_screen.dart';
import 'package:baakas_seller/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:baakas_seller/features/shop/screens/products_seller/product_model.dart';
import 'package:baakas_seller/features/shop/screens/products_seller/widgets/product_list_items.dart';
import 'package:baakas_seller/features/shop/screens/products_seller/widgets/product_searchbar.dart';
import '../../../../../utils/constants/colors.dart';

class ManageProductsScreenSeller extends StatefulWidget {
  const ManageProductsScreenSeller({super.key});

  @override
  State<ManageProductsScreenSeller> createState() =>
      _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreenSeller> {
  List<ProductModelSeller> products = [
    ProductModelSeller(
      id: '1',
      title: 'T-Shirt',
      images: [BaakasImages.productImage1],
      status: 'Active',
      stock: 10,
      variants: {'color': 'Blue', 'size': 'M'},
    ),
    ProductModelSeller(
      id: '2',
      title: 'Sneakers',
      images: [BaakasImages.productImage2],
      status: 'Out of Stock',
      stock: 0,
      variants: {'color': 'Black', 'size': '42'},
    ),
  ];

  String _searchQuery = '';

  // Add a new product

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredProducts =
        products
            .where(
              (product) => product.title.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
            )
            .toList();

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('Manage Products', style: theme.textTheme.titleLarge),
          centerTitle: true,
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: 0,
        ),
        body: Column(
          children: [
            ProductSearchBar(
              onSearch: (query) => setState(() => _searchQuery = query),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ProductListItem(
                    product: product,
                    onEdit: () {
                      // Edit functionality here
                    },
                    onDelete: () {
                      setState(() {
                        products.remove(product);
                      });
                    },
                    onToggleStatus: (isActive) {
                      setState(() {
                        product.status = isActive ? 'Active' : 'Inactive';
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: FloatingActionButton(
            onPressed: () async {
              final newProduct = await Navigator.push<ProductModelSeller>(
                context,
                MaterialPageRoute(builder: (_) => const AddProductScreen()),
              );
              if (newProduct != null) {
                setState(() {
                  products.add(newProduct);
                });
              }
            },
            backgroundColor: BaakasColors.primaryColor,
            child: Icon(Icons.add, color: theme.colorScheme.onPrimary),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
