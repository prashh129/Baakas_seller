import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModelSeller {
  final String id;
  final String title;
  final List<String> images;
  String status;
  final int stock;
  final Map<String, dynamic> variants;
  bool isFeatured;
  final String? description;
  final double? price;
  final double? discountPrice;
  final String? category;
  final List<String>? tags;
  final List<String>? categories;
  final List<String>? categoryIds;
  final String? thumbnail;
  final String? productType;
  final int soldQuantity;
  final DateTime? createdAt;
  final String? sellerId;

  ProductModelSeller({
    required this.id,
    required this.title,
    required this.images,
    required this.status,
    required this.stock,
    required this.variants,
    this.isFeatured = false,
    this.description,
    this.price,
    this.discountPrice,
    this.category,
    this.tags,
    this.categories,
    this.categoryIds,
    this.thumbnail,
    this.productType,
    this.soldQuantity = 0,
    this.createdAt,
    this.sellerId,
  });

  factory ProductModelSeller.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModelSeller(
      id: doc.id,
      title: data['title'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      status: data['status'] ?? '',
      stock: data['totalStock'] ?? 0,
      variants: data['variants'] ?? {},
      isFeatured: data['isFeatured'] ?? false,
      description: data['description'],
      price: data['price']?.toDouble(),
      discountPrice: data['discountPrice']?.toDouble(),
      category: data['category'],
      tags: List<String>.from(data['tags'] ?? []),
      categories: List<String>.from(data['categories'] ?? []),
      categoryIds: List<String>.from(data['categoryIds'] ?? []),
      thumbnail: data['thumbnail'],
      productType: data['productType'],
      soldQuantity: data['soldQuantity'] ?? 0,
      createdAt: data['createdAt']?.toDate(),
      sellerId: data['sellerId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'images': images,
      'status': status,
      'totalStock': stock,
      'variants': variants,
      'isFeatured': isFeatured,
      'description': description,
      'price': price,
      'discountPrice': discountPrice,
      'category': category,
      'tags': tags,
      'categories': categories,
      'categoryIds': categoryIds,
      'thumbnail': thumbnail,
      'productType': productType,
      'soldQuantity': soldQuantity,
      'createdAt': createdAt,
      'sellerId': sellerId,
    };
  }
}
