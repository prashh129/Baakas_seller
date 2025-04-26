import 'package:baakas_seller/utils/exceptions/firebase_exceptions.dart';
import 'package:baakas_seller/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/shop/models/category_model.dart';
import '../../../features/shop/models/product_category_model.dart';
import '../../../utils/constants/enums.dart';
import '../../services/cloud_storage/firebase_storage_service.dart';
import 'package:path/path.dart' as path;

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /* ---------------------------- FUNCTIONS ---------------------------------*/

  /// Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      print('Fetching categories from Firestore...');
      final snapshot = await _db.collection("Categories").get();
      print('Got ${snapshot.docs.length} categories from Firestore');
      
      final result = snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      print('Mapped ${result.length} categories to models');
      
      return result;
    } on FirebaseException catch (e) {
      print('Firebase error fetching categories: ${e.message}');
      throw BaakasFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      print('Platform error fetching categories: ${e.message}');
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      print('Unexpected error fetching categories: $e');
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get Featured categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot =
          await _db
              .collection("Categories")
              .where('ParentId', isEqualTo: categoryId)
              .get();
      final result =
          snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload Categories to the Cloud Firebase
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      final storage = Get.put(TFirebaseStorageService());

      for (var category in categories) {
        Map<String, dynamic> categoryData = category.toJson();

        // Handle image upload if image path is provided
        if (category.image != null && category.image!.isNotEmpty) {
          try {
            final file = await storage.getImageDataFromAssets(category.image!);
            final url = await storage.uploadImageData(
              'Categories',
              file,
              path.basename(category.name),
              MediaCategory.categories.name,
            );
            categoryData['image'] = url;
          } catch (e) {
            print('Error uploading image for category ${category.name}: $e');
            // Continue without image if upload fails
            categoryData['image'] = null;
          }
        }

        // Store Category in Firestore
        await _db.collection("Categories").doc(category.id).set(categoryData);
      }
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload Product Categories to the Cloud Firebase
  Future<void> uploadProductCategoryDummyData(
    List<ProductCategoryModel> productCategory,
  ) async {
    try {
      for (var entry in productCategory) {
        await _db.collection("ProductCategory").doc().set(entry.toJson());
      }
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
