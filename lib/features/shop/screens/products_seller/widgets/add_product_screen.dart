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
    if (widget.productToEdit != null) {
      _titleController.text = widget.productToEdit!.title;
      _descriptionController.text = widget.productToEdit!.description ?? '';
      _priceController.text = widget.productToEdit!.price?.toString() ?? '';
      _discountController.text = widget.productToEdit!.discountPrice?.toString() ?? '';
      
      // Initialize variants if editing
      if (widget.productToEdit!.variants.isNotEmpty) {
        final variants = widget.productToEdit!.variants;
        _selectedSizes = List<String>.from(variants['sizes'] ?? []);
        _selectedColors = List<String>.from(variants['colors'] ?? []);
        _variantStock = Map<String, Map<String, int>>.from(variants['stock'] ?? {});
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

    setState(() => _isLoading = true);

    try {
      List<String> imageUrls = [];

      for (var image in _images) {
        final fileName = const Uuid().v4();
        final ref = FirebaseStorage.instance.ref().child(
          'product_images/$fileName',
        );
        await ref.putFile(image);
        final url = await ref.getDownloadURL();
        imageUrls.add(url);
      }

      // Calculate total stock
      int totalStock = 0;
      for (var colorMap in _variantStock.values) {
        for (var quantity in colorMap.values) {
          totalStock += quantity;
        }
      }

      final productData = {
        'title': _titleController.text,
        'description': _descriptionController.text.trim(),
        'price': double.parse(_priceController.text),
        'discountPrice': _discountController.text.isNotEmpty 
            ? double.parse(_discountController.text) 
            : null,
        'categories': categoryController.selectedCategories.map((c) => c.name).toList(),
        'categoryIds': categoryController.selectedCategories.map((c) => c.id).toList(),
        'tags': _tags.map((tag) => tag.trim()).toList(),
        'images': imageUrls,
        'status': 'Active',
        'createdAt': Timestamp.now(),
        'sellerId': FirebaseAuth.instance.currentUser?.uid,
        'variants': {
          'sizes': _selectedSizes,
          'colors': _selectedColors,
          'stock': _variantStock,
        },
        'totalStock': totalStock,
        'isFeatured': false,
        'soldQuantity': 0,
        'productType': 'variable',
        'thumbnail': imageUrls.isNotEmpty ? imageUrls[0] : '',
      };

      // Save to seller's collection
      final sellerDocRef = await FirebaseFirestore.instance
          .collection('Sellers')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('seller_products')
          .add(productData);

      final newProduct = ProductModelSeller(
        id: sellerDocRef.id,
        title: _titleController.text,
        images: imageUrls,
        status: 'Active',
        stock: totalStock,
        variants: productData['variants'] as Map<String, dynamic>,
        description: _descriptionController.text.trim(),
        price: double.parse(_priceController.text),
        discountPrice: _discountController.text.isNotEmpty 
            ? double.parse(_discountController.text) 
            : null,
        categories: categoryController.selectedCategories.map((c) => c.name).toList(),
        categoryIds: categoryController.selectedCategories.map((c) => c.id).toList(),
        tags: _tags.map((tag) => tag.trim()).toList(),
        thumbnail: imageUrls.isNotEmpty ? imageUrls[0] : '',
        productType: 'variable',
        soldQuantity: 0,
        createdAt: DateTime.now(),
        sellerId: FirebaseAuth.instance.currentUser?.uid,
      );

      if (!mounted) return;
      Navigator.pop(context, newProduct);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
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
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySelection() {
    final categoryController = Get.put(CategoryController());
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Obx(() {
        if (categoryController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (categoryController.categories.isEmpty) {
          return const Center(child: Text('No categories available'));
        }
        
        return InputDecorator(
          decoration: InputDecoration(
            prefixIcon: const Icon(Iconsax.category),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: ExpansionTile(
            title: Row(
              children: [
                const Text(
                  'Select Categories',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (categoryController.selectedCategories.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${categoryController.selectedCategories.length} selected',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            leading: const SizedBox.shrink(),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categoryController.categories.length,
                  itemBuilder: (context, index) {
                    final category = categoryController.categories[index];
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          categoryController.toggleCategory(category);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Row(
                            children: [
                              Checkbox(
                                value: categoryController.isCategorySelected(category),
                                onChanged: (bool? value) {
                                  if (value != null) {
                                    categoryController.toggleCategory(category);
                                  }
                                },
                                activeColor: Theme.of(context).primaryColor,
                                checkColor: Colors.white,
                              ),
                              Expanded(
                                child: Text(
                                  category.name,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (categoryController.selectedCategories.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Wrap(
                    spacing: 8,
                    children: categoryController.selectedCategories.map((category) {
                      return Chip(
                        label: Text(category.name),
                        onDeleted: () {
                          categoryController.toggleCategory(category);
                        },
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTagsSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputDecorator(
            decoration: InputDecoration(
              labelText: 'Tags',
              prefixIcon: const Icon(Iconsax.tag),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _tagController,
                        decoration: const InputDecoration(
                          hintText: 'Add a tag and press comma',
                          border: InputBorder.none,
                        ),
                        onSubmitted: (value) {
                          if (value.endsWith(',')) {
                            _addTag(value.substring(0, value.length - 1));
                          }
                        },
                        onChanged: (value) {
                          if (value.endsWith(',')) {
                            _addTag(value.substring(0, value.length - 1));
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Obx(() => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _tags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      onDeleted: () => _removeTag(tag),
                      deleteIcon: const Icon(Icons.close, size: 18),
                    );
                  }).toList(),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVariantSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Variants',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        // Size Selection
        Wrap(
          spacing: 8,
          children: [
            ..._availableSizes.map((size) {
              final isSelected = _selectedSizes.contains(size);
              return FilterChip(
                label: Text(size),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedSizes.add(size);
                    } else {
                      _selectedSizes.remove(size);
                      // Remove stock entries for this size
                      _variantStock.remove(size);
                    }
                  });
                },
              );
            }),
          ],
        ),
        const SizedBox(height: 16),
        // Color Selection - Combined predefined and custom colors
        Wrap(
          spacing: 8,
          children: [
            ..._availableColors.map((color) {
              final isSelected = _selectedColors.contains(color);
              return FilterChip(
                label: Text(color),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedColors.add(color);
                    } else {
                      _selectedColors.remove(color);
                      // Remove stock entries for this color
                      for (var size in _variantStock.keys) {
                        _variantStock[size]?.remove(color);
                      }
                    }
                  });
                },
              );
            }),
            // Show custom colors
            ..._selectedColors
                .where((color) => !_availableColors.contains(color))
                .map((color) {
              return FilterChip(
                label: Text(color),
                selected: true,
                onSelected: (selected) {
                  setState(() {
                    _selectedColors.remove(color);
                    // Remove stock entries for this color
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
        // Custom Color Input
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _customColorController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Add Custom Color',
                  labelStyle: const TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.white30),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _addCustomColor,
              child: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Stock Management
        if (_selectedSizes.isNotEmpty && _selectedColors.isNotEmpty)
          ..._selectedSizes.map((size) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stock for $size',
                  style: const TextStyle(
                    color: Colors.white,
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
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            initialValue: _variantStock[size]?[color]?.toString() ?? '0',
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Quantity',
                              labelStyle: const TextStyle(color: Colors.white70),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(color: Colors.white30),
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
    );
  }

  Widget _buildImagePreview() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white30),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Expanded(
            child: _images.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, color: Colors.white70, size: 32),
                        SizedBox(height: 8),
                        Text(
                          'No images selected',
                          style: TextStyle(color: Colors.white70),
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
                                border: Border.all(color: Colors.white30),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_photo_alternate, color: Colors.white70, size: 32),
                                  SizedBox(height: 8),
                                  Text(
                                    'Add More',
                                    style: TextStyle(color: Colors.white70),
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
                    icon: const Icon(Icons.add_photo_alternate),
                    label: const Text('Select Images'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _pickImageFromCamera,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Take Photo'),
                    style: ElevatedButton.styleFrom(
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const BaakasAppBar(
        showBackArrow: true,
        title: Text('Add Product'),
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
                label: 'Price',
                icon: Iconsax.dollar_circle,
                validator: (val) => val!.isEmpty ? 'Enter product price' : null,
              ),
              _buildFormField(
                controller: _discountController,
                label: 'Discount Price (Optional)',
                icon: Iconsax.discount_shape,
              ),
              _buildCategorySelection(),
              _buildTagsSection(),
              const SizedBox(height: 16),
              _buildVariantSection(),
              const SizedBox(height: 16),
              const Text(
                'Product Images',
                style: TextStyle(
                  color: Colors.white,
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
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Add Product'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
