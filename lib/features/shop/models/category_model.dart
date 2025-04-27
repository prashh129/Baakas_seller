import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  final String? description;
  String? image;
  final bool isActive;
  final bool isFeatured;
  final String parentId;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    this.isActive = true,
    this.isFeatured = false,
    this.parentId = '',
  });

  /// Empty Helper Function
  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', isActive: false);

  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Description': description,
      'Image': image,
      'IsActive': isActive,
      'IsFeatured': isFeatured,
      'ParentId': parentId,
    };
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory CategoryModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;

      // Map JSON Record to the Model
      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        description: data['Description'],
        image: data['Image'],
        isActive: data['IsActive'] ?? true,
        isFeatured: data['IsFeatured'] ?? false,
        parentId: data['ParentId'] ?? '',
      );
    } else {
      return CategoryModel.empty();
    }
  }

  factory CategoryModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() as Map<String, dynamic>;
    print('Parsing category document: ${doc.id}');
    print('Category data: $data');
    
    final category = CategoryModel(
      id: doc.id,
      name: data['Name'] ?? '',
      description: data['Description'],
      image: data['Image'],
      isActive: data['IsActive'] ?? true,
      isFeatured: data['IsFeatured'] ?? false,
      parentId: data['ParentId'] ?? '',
    );
    
    print('Created category: ${category.name} (ID: ${category.id})');
    return category;
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Description': description,
      'Image': image,
      'IsActive': isActive,
      'IsFeatured': isFeatured,
      'ParentId': parentId,
    };
  }
}
