import 'dart:io';
import 'package:baakas_seller/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:baakas_seller/features/shop/screens/products_seller/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:baakas_seller/features/shop/controllers/category_controller.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:baakas_seller/utils/constants/colors.dart';

class AddProductScreen extends StatefulWidget {
  final ProductModelSeller? productToEdit;

  const AddProductScreen({super.key, this.productToEdit});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountController = TextEditingController();
  final _customColorController = TextEditingController();

  final List<File> _images = [];
  bool _isLoading = false;
  
  // Variants management
  List<String> _selectedSizes = [];
  List<String> _selectedColors = [];
  Map<String, Map<String, int>> _variantStock = {}; // {size: {color: quantity}}

  final List<String> _availableSizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  final List<String> _availableColors = ['Red', 'Blue', 'Green', 'Black', 'White'];

  final RxList<String> _tags = <String>[].obs;
  final _tagController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    // Initialize CategoryController if not already initialized
    if (!Get.isRegistered<CategoryController>()) {
      Get.put(CategoryController());
    }
    
    // Load categories if empty
    final categoryController = Get.find<CategoryController>();
    if (categoryController.categories.isEmpty) {
      categoryController.loadCategories();
    }
    
    if (widget.productToEdit != null) {
      _titleController.text = widget.productToEdit!.title;
      _descriptionController.text = widget.productToEdit!.description ?? '';
      _priceController.text = widget.productToEdit!.price?.toString() ?? '';
      _discountController.text = widget.productToEdit!.discountPrice?.toString() ?? '';
      
      // Initialize variants if editing
      if (widget.productToEdit!.variants.isNotEmpty) {
        final variants = widget.productToEdit!.variants;
        _selectedSizes = variants['sizes'] is List ? List<String>.from(variants['sizes']) : [];
        _selectedColors = variants['colors'] is List ? List<String>.from(variants['colors']) : [];
        _variantStock = variants['stock'] is Map ? Map<String, Map<String, int>>.from(variants['stock']) : {};
      }

      // Initialize tags
      if (widget.productToEdit!.tags != null) {
        _tags.value = List<String>.from(widget.productToEdit!.tags!);
      }

      // Load existing images
      if (widget.productToEdit!.images.isNotEmpty) {
        setState(() {
          _images.clear();
          for (var imageUrl in widget.productToEdit!.images) {
            // Download and convert network images to File objects
            _loadNetworkImage(imageUrl);
          }
        });
      }
    }
  }

  Future<void> _loadNetworkImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/${imageUrl.split('/').last}');
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          _images.add(file);
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickMultipleImages() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> pickedFiles = await picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      
      if (pickedFiles.isNotEmpty) {
        setState(() {
          _images.addAll(pickedFiles.map((e) => File(e.path)));
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking images: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final picker = ImagePicker();
      final XFile? capturedImage = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      
      if (capturedImage != null) {
        setState(() {
          _images.add(File(capturedImage.path));
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error capturing image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _updateVariantStock(String size, String color, int quantity) {
    setState(() {
      if (!_variantStock.containsKey(size)) {
        _variantStock[size] = {};
      }
      _variantStock[size]![color] = quantity;
    });
  }

  void _addCustomColor() {
    if (_customColorController.text.isNotEmpty) {
      setState(() {
        _selectedColors.add(_customColorController.text);
        _customColorController.clear();
      });
    }
  }

  void _addTag(String tag) {
    if (tag.isNotEmpty) {
      _tags.add(tag.trim());
      _tagController.clear();
    }
  }

  void _removeTag(String tag) {
    _tags.remove(tag);
  }

  Future<void> _submitForm() async {
    try {
      if (!_formKey.currentState!.validate() || _images.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Fill all required fields and upload at least one image'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final categoryController = Get.find<CategoryController>();
      if (categoryController.selectedCategories.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one category'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Validate price fields
      double? price;
      double? discountPrice;
      try {
        price = double.parse(_priceController.text);
        if (_discountController.text.isNotEmpty) {
          discountPrice = double.parse(_discountController.text);
          if (discountPrice >= price) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Discount price must be less than regular price'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter valid price values'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() => _isLoading = true);

      List<String> imageUrls = [];

      // Handle image uploads
      for (var image in _images) {
        if (image.path.startsWith('http')) {
          // If it's an existing image URL, keep it
          imageUrls.add(image.path);
        } else {
          // Upload new images
          final fileName = const Uuid().v4();
          final ref = FirebaseStorage.instance.ref().child(
            'product_images/$fileName',
          );
          await ref.putFile(image);
          final url = await ref.getDownloadURL();
          imageUrls.add(url);
        }
      }

      // Calculate total stock
      int totalStock = 0;
      for (var colorMap in _variantStock.values) {
        for (var quantity in colorMap.values) {
          totalStock += quantity;
        }
      }

      final sellerId = FirebaseAuth.instance.currentUser?.uid;
      if (sellerId == null) {
        throw 'User not authenticated';
      }

      final productData = {
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'price': price,
        'discountPrice': discountPrice,
        'categories': categoryController.selectedCategories.map((c) => c.name).toList(),
        'categoryIds': categoryController.selectedCategories.map((c) => c.id).toList(),
        'tags': _tags.map((tag) => tag.trim()).toList(),
        'images': imageUrls,
        'status': widget.productToEdit?.status ?? 'pending',
        'updatedAt': Timestamp.now(),
        'sellerId': sellerId,
        'variants': {
          'sizes': _selectedSizes,
          'colors': _selectedColors,
          'stock': _variantStock,
        },
        'totalStock': totalStock,
        'isFeatured': widget.productToEdit?.isFeatured ?? false,
        'soldQuantity': widget.productToEdit?.soldQuantity ?? 0,
        'productType': 'variable',
        'thumbnail': imageUrls.isNotEmpty ? imageUrls[0] : '',
      };

      if (widget.productToEdit != null) {
        // Update existing product
        await FirebaseFirestore.instance
            .collection('Sellers')
            .doc(sellerId)
            .collection('seller_products')
            .doc(widget.productToEdit!.id)
            .update(productData);

        if (!mounted) return;
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Create new product
        productData['createdAt'] = Timestamp.now();
        await FirebaseFirestore.instance
            .collection('Sellers')
            .doc(sellerId)
            .collection('seller_products')
            .add(productData);

        if (!mounted) return;
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product added successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _customColorController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final borderColor = Theme.of(context).dividerColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        keyboardType: keyboardType,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: textColor?.withOpacity(0.7),
            fontSize: 16,
          ),
          prefixIcon: Icon(
            icon,
            color: BaakasColors.primaryColor,
          ),
          filled: true,
          fillColor: isDark ? Colors.black12 : Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: borderColor,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: borderColor,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: BaakasColors.primaryColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildCategorySelection() {
    final categoryController = Get.find<CategoryController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Obx(() {
            if (categoryController.isLoading.value) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (categoryController.categories.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'No categories available',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
              );
            }

            return InputDecorator(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Iconsax.category,
                  color: BaakasColors.primaryColor,
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: BaakasColors.primaryColor,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              child: ExpansionTile(
                title: Row(
                  children: [
                    Text(
                      'Select Categories',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    Obx(() {
                      if (categoryController.selectedCategories.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: BaakasColors.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${categoryController.selectedCategories.length} selected',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                leading: const SizedBox.shrink(),
                childrenPadding: EdgeInsets.zero,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categoryController.categories.length,
                    itemBuilder: (context, index) {
                      final category = categoryController.categories[index];
                      final isSelected = categoryController.isCategorySelected(category);
                      print('DEBUG UI: Building checkbox for ${category.name}, isSelected: $isSelected');
                      return Obx(() {
                        final isSelectedNow = categoryController.isCategorySelected(category);
                        print('DEBUG UI: Rebuilding checkbox for ${category.name}, isSelectedNow: $isSelectedNow');
                        return CheckboxListTile(
                          title: Text(
                            category.name,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ),
                          value: isSelectedNow,
                          onChanged: (selected) {
                            if (selected != null) {
                              print('DEBUG UI: Toggling ${category.name} to $selected');
                              categoryController.toggleCategory(category);
                            }
                          },
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          dense: true,
                          activeColor: BaakasColors.primaryColor,
                          checkColor: Colors.white,
                          controlAffinity: ListTileControlAffinity.leading,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: BorderSide(
                            color: isSelectedNow ? BaakasColors.primaryColor : Theme.of(context).dividerColor,
                            width: 1.5,
                          ),
                        );
                      });
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTagsSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final borderColor = Theme.of(context).dividerColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tags',
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _tagController,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Add Tag',
                    labelStyle: TextStyle(
                      color: textColor?.withOpacity(0.7),
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Iconsax.tag,
                      color: BaakasColors.primaryColor,
                    ),
                    filled: true,
                    fillColor: isDark ? Colors.black12 : Colors.grey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: borderColor,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: borderColor,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: BaakasColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      _addTag(value);
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  if (_tagController.text.isNotEmpty) {
                    _addTag(_tagController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: BaakasColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                child: const Text('Add', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Obx(() {
            if (_tags.isEmpty) {
              return const SizedBox.shrink();
            }
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _tags.map((tag) {
                return Chip(
                  label: Text(
                    tag,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: BaakasColors.primaryColor,
                  deleteIcon: const Icon(Iconsax.close_circle, color: Colors.white, size: 18),
                  onDeleted: () => _removeTag(tag),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildVariantSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final borderColor = Theme.of(context).dividerColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Variants',
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: borderColor,
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sizes',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: _availableSizes.map((size) {
                    final isSelected = _selectedSizes.contains(size);
                    return FilterChip(
                      label: Text(size),
                      selected: isSelected,
                      selectedColor: BaakasColors.primaryColor.withOpacity(0.2),
                      checkmarkColor: BaakasColors.primaryColor,
                      labelStyle: TextStyle(
                        color: isSelected ? BaakasColors.primaryColor : textColor,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedSizes.add(size);
                          } else {
                            _selectedSizes.remove(size);
                            _variantStock.remove(size);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  'Colors',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    ..._availableColors.map((color) {
                      final isSelected = _selectedColors.contains(color);
                      return FilterChip(
                        label: Text(color),
                        selected: isSelected,
                        selectedColor: BaakasColors.primaryColor.withOpacity(0.2),
                        checkmarkColor: BaakasColors.primaryColor,
                        labelStyle: TextStyle(
                          color: isSelected ? BaakasColors.primaryColor : textColor,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedColors.add(color);
                            } else {
                              _selectedColors.remove(color);
                              for (var size in _variantStock.keys) {
                                _variantStock[size]?.remove(color);
                              }
                            }
                          });
                        },
                      );
                    }),
                    ..._selectedColors
                        .where((color) => !_availableColors.contains(color))
                        .map((color) {
                      return FilterChip(
                        label: Text(color),
                        selected: true,
                        selectedColor: BaakasColors.primaryColor.withOpacity(0.2),
                        checkmarkColor: BaakasColors.primaryColor,
                        labelStyle: TextStyle(
                          color: BaakasColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        onSelected: (selected) {
                          setState(() {
                            _selectedColors.remove(color);
                            for (var size in _variantStock.keys) {
                              _variantStock[size]?.remove(color);
                            }
                          });
                        },
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _customColorController,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Add Custom Color',
                          labelStyle: TextStyle(
                            color: textColor?.withOpacity(0.7),
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Iconsax.colorfilter,
                            color: BaakasColors.primaryColor,
                          ),
                          filled: true,
                          fillColor: isDark ? Colors.black12 : Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: borderColor,
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: borderColor,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: BaakasColors.primaryColor,
                              width: 2,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _addCustomColor,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BaakasColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      child: const Text('Add', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                if (_selectedSizes.isNotEmpty && _selectedColors.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  ..._selectedSizes.map((size) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Stock for $size',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ..._selectedColors.map((color) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    color,
                                    style: TextStyle(color: textColor?.withOpacity(0.7)),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: TextFormField(
                                    initialValue: _variantStock[size]?[color]?.toString() ?? '0',
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: textColor),
                                    decoration: InputDecoration(
                                      labelText: 'Quantity',
                                      labelStyle: TextStyle(color: textColor?.withOpacity(0.7)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: borderColor),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: borderColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: BaakasColors.primaryColor),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      _updateVariantStock(
                                        size,
                                        color,
                                        int.tryParse(value) ?? 0,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: 16),
                      ],
                    );
                  }),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white70 : Colors.black87;
    final borderColor = isDark ? Colors.white30 : Colors.black26;
    final iconColor = isDark ? Colors.white70 : Colors.black54;
    
    return Container(
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(15),
        color: isDark ? Colors.black12 : Colors.grey.shade100,
      ),
      child: Column(
        children: [
          Expanded(
            child: _images.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, color: iconColor, size: 32),
                        const SizedBox(height: 8),
                        Text(
                          'No images selected',
                          style: TextStyle(color: textColor),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _images.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: _pickMultipleImages,
                            child: Container(
                              width: 120,
                              decoration: BoxDecoration(
                                border: Border.all(color: borderColor),
                                borderRadius: BorderRadius.circular(10),
                                color: isDark ? Colors.black26 : Colors.grey.shade200,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_photo_alternate, color: iconColor, size: 32),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Add More',
                                    style: TextStyle(color: textColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        final imageIndex = index - 1;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: FileImage(_images[imageIndex]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.close, color: Colors.white),
                                    onPressed: () => _removeImage(imageIndex),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
          ),
          if (_images.isEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickMultipleImages,
                    icon: const Icon(Icons.add_photo_alternate, color: Colors.white),
                    label: const Text('Select Images', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BaakasColors.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _pickImageFromCamera,
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                    label: const Text('Take Photo', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BaakasColors.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final borderColor = Theme.of(context).dividerColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: BaakasColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.productToEdit != null ? 'Edit Product' : 'Add Product',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFormField(
                controller: _titleController,
                label: 'Product Title',
                icon: Iconsax.box,
                validator: (val) => val!.isEmpty ? 'Enter product title' : null,
              ),
              _buildFormField(
                controller: _descriptionController,
                label: 'Description',
                icon: Iconsax.document_text,
                maxLines: 3,
                validator: (val) => val!.isEmpty ? 'Enter product description' : null,
              ),
              _buildFormField(
                controller: _priceController,
                label: 'Price (Rs)',
                icon: Icons.currency_rupee,
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? 'Enter product price' : null,
              ),
              _buildFormField(
                controller: _discountController,
                label: 'Discount Price (Rs) (Optional)',
                icon: Icons.currency_rupee,
                keyboardType: TextInputType.number,
              ),
              _buildCategorySelection(),
              _buildTagsSection(),
              const SizedBox(height: 16),
              _buildVariantSection(),
              const SizedBox(height: 16),
              Text(
                'Product Images',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              _buildImagePreview(),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BaakasColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          widget.productToEdit != null ? 'Save Product' : 'Add Product',
                          style: const TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
