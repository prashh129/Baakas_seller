import 'package:cloud_firestore/cloud_firestore.dart';

import 'product_attribute_model.dart';
import 'product_variation_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  int soldQuantity;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  String? categoryId;
  String productType;
  String? description;
  List<String>? images;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.soldQuantity = 0,
    this.date,
    this.images,
    this.salePrice = 0.0,
    this.isFeatured,
    this.categoryId,
    this.description,
    this.productAttributes,
    this.productVariations,
  });

  /// Create Empty func for clean code
  static ProductModel empty() => ProductModel(id: '', title: '', stock: 0, price: 0, thumbnail: '', productType: '', soldQuantity: 0);

  /// Json Format
  toJson() {
    return {
      'SKU': sku,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Images': images ?? [],
      'Thumbnail': thumbnail,
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Description': description,
      'ProductType': productType,
      'SoldQuantity': soldQuantity,
      'ProductAttributes': productAttributes != null ? productAttributes!.map((e) => e.toJson()).toList() : [],
      'ProductVariations': productVariations != null ? productVariations!.map((e) => e.toJson()).toList() : [],
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    final variants = data['variants'] as Map<String, dynamic>? ?? {};
    
    return ProductModel(
      id: document.id,
      title: data['title'] ?? '',
      price: double.parse((data['price'] ?? 0.0).toString()),
      stock: data['totalStock'] ?? 0,
      soldQuantity: data['soldQuantity'] ?? 0,
      isFeatured: data['isFeatured'] ?? false,
      salePrice: double.parse((data['discountPrice'] ?? 0.0).toString()),
      thumbnail: data['thumbnail'] ?? '',
      categoryId: data['category'] ?? '',
      description: data['description'] ?? '',
      productType: data['productType'] ?? '',
      images: data['images'] != null ? List<String>.from(data['images']) : [],
      productAttributes: [
        ProductAttributeModel(
          name: 'Size',
          values: _getAttributeValues(variants['sizes']),
        ),
        ProductAttributeModel(
          name: 'Color',
          values: _getAttributeValues(variants['colors']),
        ),
      ],
      productVariations: _createVariationsFromData(data),
    );
  }

  // Map Json-oriented document snapshot from Firebase to Model
  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    final variants = data['variants'] as Map<String, dynamic>? ?? {};
    
    return ProductModel(
      id: document.id,
      title: data['title'] ?? '',
      price: double.parse((data['price'] ?? 0.0).toString()),
      stock: data['totalStock'] ?? 0,
      soldQuantity: data['soldQuantity'] ?? 0,
      isFeatured: data['isFeatured'] ?? false,
      salePrice: double.parse((data['discountPrice'] ?? 0.0).toString()),
      thumbnail: data['thumbnail'] ?? '',
      categoryId: data['category'] ?? '',
      description: data['description'] ?? '',
      productType: data['productType'] ?? '',
      images: data['images'] != null ? List<String>.from(data['images']) : [],
      productAttributes: [
        ProductAttributeModel(
          name: 'Size',
          values: _getAttributeValues(variants['sizes']),
        ),
        ProductAttributeModel(
          name: 'Color',
          values: _getAttributeValues(variants['colors']),
        ),
      ],
      productVariations: _createVariationsFromData(data),
    );
  }

  static List<String> _getAttributeValues(dynamic value) {
    if (value == null) return [];
    if (value is String) return value.split(',');
    if (value is List) return value.map((e) => e.toString()).toList();
    return [];
  }

  static List<ProductVariationModel> _createVariationsFromData(Map<String, dynamic> data) {
    final variants = data['variants'] as Map<String, dynamic>?;
    if (variants == null) return [];

    final sizes = _getAttributeValues(variants['sizes']);
    final colors = _getAttributeValues(variants['colors']);
    final stock = variants['stock'] as Map<String, dynamic>? ?? {};

    return sizes.expand((size) => colors.map((color) {
      final stockQty = (stock[size] as Map<String, dynamic>?)?[color] ?? 0;
      return ProductVariationModel(
        id: '${size}_$color',
        stock: stockQty,
        price: double.parse((data['price'] ?? 0.0).toString()),
        salePrice: double.parse((data['discountPrice'] ?? 0.0).toString()),
        image: data['thumbnail'] ?? '',
        attributeValues: {
          'Size': size,
          'Color': color,
        },
      );
    })).toList();
  }
}
