import 'package:baakas_seller/features/shop/screens/products_seller/widgets/add_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:baakas_seller/features/shop/screens/products_seller/product_model.dart';
import 'package:baakas_seller/features/shop/screens/products_seller/widgets/product_list_items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../features/shop/controllers/category_controller.dart';
import '../../../../../../navigation/navigation_controller.dart';

class ManageProductsScreen extends StatefulWidget {
  const ManageProductsScreen({super.key});

  @override
  State<ManageProductsScreen> createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final RxString _selectedStatus = 'approved'.obs;
  String _searchQuery = '';
  bool isGridView = false;
  final searchController = TextEditingController();
  final navigationController = Get.find<NavigationController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: navigationController.productsTabIndex.value);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _selectedStatus.value = _getStatusFromIndex(_tabController.index);
        navigationController.productsTabIndex.value = _tabController.index;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  String _getStatusFromIndex(int index) {
    switch (index) {
      case 0:
        return 'approved';
      case 1:
        return 'pending';
      case 2:
        return 'rejected';
      default:
        return 'approved';
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return BaakasColors.warning;
      case 'approved':
        return BaakasColors.success;
      case 'rejected':
        return BaakasColors.error;
      default:
        return BaakasColors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Iconsax.timer_1;
      case 'approved':
        return Iconsax.tick_circle;
      case 'rejected':
        return Iconsax.close_circle;
      default:
        return Iconsax.box;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = BaakasHelperFunctions.isDarkMode(context);
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: isDark ? BaakasColors.dark : BaakasColors.light,
      appBar: AppBar(
        title: Text(
          'Manage Products',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: BaakasColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: BaakasColors.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isGridView ? Iconsax.element_3 : Iconsax.element_4,
              color: BaakasColors.white,
            ),
            onPressed: () => setState(() => isGridView = !isGridView),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            color: BaakasColors.primaryColor,
            child: TabBar(
              controller: _tabController,
              indicatorColor: BaakasColors.white,
              indicatorWeight: 3,
              labelColor: BaakasColors.white,
              unselectedLabelColor: BaakasColors.white.withOpacity(0.7),
              tabs: [
                Tab(
                  icon: Icon(
                    Iconsax.tick_circle,
                    color: BaakasColors.white,
                  ),
                  text: 'Approved',
                ),
                Tab(
                  icon: Icon(
                    Iconsax.timer_1,
                    color: BaakasColors.white,
                  ),
                  text: 'Pending',
                ),
                Tab(
                  icon: Icon(
                    Iconsax.close_circle,
                    color: BaakasColors.white,
                  ),
                  text: 'Rejected',
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(BaakasSizes.md),
            child: BaakasSearchContainer(
              text: 'Search products...',
              icon: Iconsax.search_normal,
              showBackground: true,
              showBoarder: true,
              onTap: () {
                // Handle search tap
              },
            ),
          ),

          // Products List/Grid
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProductList('approved'),
                _buildProductList('pending'),
                _buildProductList('rejected'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          try {
            // Ensure CategoryController is initialized
            if (!Get.isRegistered<CategoryController>()) {
              Get.put(CategoryController());
            }
            
            final categoryController = Get.find<CategoryController>();
            
            // Load categories if empty
            if (categoryController.categories.isEmpty) {
              await categoryController.loadCategories();
            }
            
            if (!mounted) return;
            
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddProductScreen(),
              ),
            );
            
            if (result != null && mounted) {
              setState(() {});
            }
          } catch (e) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${e.toString()}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        icon: Icon(Iconsax.add, color: BaakasColors.primaryColor),
        label: Text(
          'Add Product',
          style: TextStyle(
            color: BaakasColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: BaakasColors.primaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildProductList(String status) {
    final sellerId = FirebaseAuth.instance.currentUser?.uid;
    if (sellerId == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.warning_2,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'User not authenticated',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Sellers')
          .doc(sellerId)
          .collection('seller_products')
          .where('status', isEqualTo: status)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.warning_2,
                  size: 64,
                  color: Colors.red[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red[600],
                  ),
                ),
              ],
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final Set<String> seenIds = {};
        final products = snapshot.data?.docs
            .map((doc) => ProductModelSeller.fromFirestore(doc))
            .where((product) {
              if (seenIds.contains(product.id)) return false;
              seenIds.add(product.id);
              return product.title.toLowerCase().contains(_searchQuery.toLowerCase());
            })
            .toList() ?? [];

        if (products.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getStatusIcon(status),
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  status == 'pending'
                      ? 'No pending products'
                      : status == 'approved'
                          ? 'No approved products'
                          : 'No rejected products',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        if (isGridView) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductListItem(
                product: product,
                onStatusChanged: (newStatus) {
                  FirebaseFirestore.instance
                      .collection('Sellers')
                      .doc(sellerId)
                      .collection('seller_products')
                      .doc(product.id)
                      .update({'status': newStatus});
                },
              );
            },
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ProductListItem(
                product: product,
                onStatusChanged: (newStatus) {
                  FirebaseFirestore.instance
                      .collection('Sellers')
                      .doc(sellerId)
                      .collection('seller_products')
                      .doc(product.id)
                      .update({'status': newStatus});
                },
              ),
            );
          },
        );
      },
    );
  }
}
