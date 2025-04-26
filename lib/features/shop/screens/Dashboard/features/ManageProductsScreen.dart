import 'package:baakas_seller/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:baakas_seller/common/widgets/layouts/grid_layout.dart';
import 'package:baakas_seller/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:baakas_seller/common/widgets/shimmers/shimmer.dart';
import 'package:baakas_seller/features/shop/controllers/product/product_controller.dart';
import 'package:baakas_seller/features/shop/screens/products_seller/widgets/add_product_screen.dart';
import 'package:baakas_seller/features/shop/models/product_model.dart';
import 'package:baakas_seller/features/shop/screens/products_seller/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';

class ManageProductsScreen extends StatefulWidget {
  const ManageProductsScreen({super.key});

  @override
  State<ManageProductsScreen> createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  final controller = Get.put(ProductController());
  final searchController = TextEditingController();
  bool isGridView = true;
  String selectedSort = 'name';
  String selectedCategory = 'all';
  RangeValues priceRange = const RangeValues(0, 100000);

  @override
  void initState() {
    super.initState();
    controller.fetchFeaturedProducts();
  }

  ProductModelSeller _convertToSellerModel(ProductModel model) {
    return ProductModelSeller(
      id: model.id,
      title: model.title,
      images: [model.thumbnail],
      status: 'Active',
      stock: 0,
      variants: {},
      price: model.price,
      description: model.description,
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Filter Products',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              
              // Category Filter
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  prefixIcon: Icon(Iconsax.category),
                ),
                items: [
                  'all',
                  'electronics',
                  'clothing',
                  'food',
                  'books',
                  'other'
                ].map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.toUpperCase()),
                )).toList(),
                onChanged: (value) {
                  setState(() => selectedCategory = value!);
                },
              ),
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              
              // Price Range Filter
              Text(
                'Price Range: \$${priceRange.start.round()} - \$${priceRange.end.round()}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              RangeSlider(
                values: priceRange,
                min: 0,
                max: 100000,
                divisions: 100,
                labels: RangeLabels(
                  '\$${priceRange.start.round()}',
                  '\$${priceRange.end.round()}',
                ),
                onChanged: (values) {
                  setState(() => priceRange = values);
                },
              ),
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              
              // Apply Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSortDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sort Products',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: BaakasSizes.spaceBtwItems),
            ListTile(
              leading: const Icon(Iconsax.sort),
              title: const Text('Name (A-Z)'),
              onTap: () {
                setState(() => selectedSort = 'name');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.money),
              title: const Text('Price (Low to High)'),
              onTap: () {
                setState(() => selectedSort = 'price_asc');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.money),
              title: const Text('Price (High to Low)'),
              onTap: () {
                setState(() => selectedSort = 'price_desc');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.calendar),
              title: const Text('Date (Newest)'),
              onTap: () {
                setState(() => selectedSort = 'date_desc');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.calendar),
              title: const Text('Date (Oldest)'),
              onTap: () {
                setState(() => selectedSort = 'date_asc');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showProductActions(ProductModelSeller product) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text('Edit Product'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => AddProductScreen(productToEdit: product));
              },
            ),
            ListTile(
              leading: Icon(
                product.status == 'Active' ? Icons.toggle_off : Icons.toggle_on,
                color: Colors.green,
              ),
              title: Text(
                product.status == 'Active' ? 'Mark as Inactive' : 'Mark as Active',
              ),
              onTap: () {
                Navigator.pop(context);
                final newStatus = product.status == 'Active' ? 'Inactive' : 'Active';
                FirebaseFirestore.instance
                    .collection('Sellers')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection('seller_products')
                    .doc(product.id)
                    .update({'status': newStatus});
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Product'),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(product);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(ProductModelSeller product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              FirebaseFirestore.instance
                  .collection('Sellers')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection('seller_products')
                  .doc(product.id)
                  .delete();
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

  @override
  Widget build(BuildContext context) {
    final isDark = BaakasHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: BaakasAppBar(
        title: Text(
          'Manage Products',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            icon: Icon(
              isGridView ? Iconsax.row_vertical : Iconsax.grid_5,
              color: isDark ? BaakasColors.white : BaakasColors.black,
            ),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
          IconButton(
            icon: const Icon(Iconsax.filter),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: const Icon(Iconsax.sort),
            onPressed: _showSortDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          BaakasSearchContainer(
            text: 'Search products...',
            icon: Iconsax.search_normal,
            showBackground: true,
            showBoarder: true,
            onTap: () {
              // Handle search tap
            },
          ),

          // Products List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const BaakasShimmerEffect(
                  width: double.infinity,
                  height: 120,
                  radius: 15,
                );
              }

              if (controller.featuredProducts.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[800] : Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Iconsax.box,
                          size: 48,
                          color: isDark ? Colors.grey[600] : Colors.grey[400],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No products found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add your first product to get started',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey[500] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Apply filters and sorting
              var filteredProducts = controller.featuredProducts.where((product) {
                final matchesSearch = product.title
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase());
                final matchesCategory = selectedCategory == 'all' ||
                    product.categoryId?.toLowerCase() == selectedCategory.toLowerCase();
                final matchesPrice = product.price >= priceRange.start &&
                    product.price <= priceRange.end;
                return matchesSearch && matchesCategory && matchesPrice;
              }).toList();

              // Apply sorting
              switch (selectedSort) {
                case 'name':
                  filteredProducts.sort((a, b) => a.title.compareTo(b.title));
                  break;
                case 'price_asc':
                  filteredProducts.sort((a, b) => a.price.compareTo(b.price));
                  break;
                case 'price_desc':
                  filteredProducts.sort((a, b) => b.price.compareTo(a.price));
                  break;
                case 'date_desc':
                  filteredProducts.sort((a, b) => (b.date ?? DateTime.now()).compareTo(a.date ?? DateTime.now()));
                  break;
                case 'date_asc':
                  filteredProducts.sort((a, b) => (a.date ?? DateTime.now()).compareTo(b.date ?? DateTime.now()));
                  break;
              }

              return isGridView
                  ? BaakasGridLayout(
                      itemCount: filteredProducts.length,
                      itemBuilder: (_, index) => BaakasProductCardVertical(
                        product: filteredProducts[index],
                        onEdit: () => _showProductActions(_convertToSellerModel(filteredProducts[index])),
                        onDelete: () => controller.deleteProduct(filteredProducts[index].id),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
                      itemCount: filteredProducts.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: BaakasSizes.spaceBtwItems),
                      itemBuilder: (_, index) => BaakasProductCardVertical(
                        product: filteredProducts[index],
                        onEdit: () => _showProductActions(_convertToSellerModel(filteredProducts[index])),
                        onDelete: () => controller.deleteProduct(filteredProducts[index].id),
                      ),
                    );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddProductScreen()),
        child: const Icon(Iconsax.add),
      ),
    );
  }
} 