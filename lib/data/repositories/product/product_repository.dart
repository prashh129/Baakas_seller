import 'dart:io';

import 'package:baakas_seller/data/repositories/brands/brand_repository.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../features/shop/models/product_model.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../services/cloud_storage/firebase_storage_service.dart';
import 'package:path/path.dart' as path;

/// Repository for managing product-related data and operations.
class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  /// Firestore instance for database interactions.
  final _db = FirebaseFirestore.instance;

  /* ---------------------------- FUNCTIONS ---------------------------------*/

  /// Get limited featured products.
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot =
          await _db
              .collection('Sellers')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('seller_products')
              .where('isFeatured', isEqualTo: true)
              .limit(4)
              .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get limited featured products.
  Future<ProductModel> getSingleProduct(String productId) async {
    try {
      final snapshot = await _db
          .collection('Sellers')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('seller_products')
          .doc(productId)
          .get();
      return ProductModel.fromSnapshot(snapshot);
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get all featured products using Stream.
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    final snapshot =
        await _db
            .collection('Sellers')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('seller_products')
            .where('isFeatured', isEqualTo: true)
            .get();
    return snapshot.docs
        .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
        .toList();
  }

  /// Get Products based on the Brand
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList =
          querySnapshot.docs
              .map((doc) => ProductModel.fromQuerySnapshot(doc))
              .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get favorite products based on a list of product IDs.
  Future<List<ProductModel>> getFavouriteProducts(
    List<String> productIds,
  ) async {
    try {
      final snapshot =
          await _db
              .collection('Sellers')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('seller_products')
              .where(FieldPath.documentId, whereIn: productIds)
              .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Fetches products for a specific category.
  /// If the limit is -1, retrieves all products for the category; otherwise, limits the result based on the provided limit.
  /// Returns a list of [ProductModel] objects.
  Future<List<ProductModel>> getProductsForCategory({
    required String categoryId,
    int limit = 4,
  }) async {
    try {
      final snapshot =
          await _db
              .collection('Sellers')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('seller_products')
              .where('category', isEqualTo: categoryId)
              .limit(limit)
              .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Fetches products for a specific brand.
  /// If the limit is -1, retrieves all products for the brand; otherwise, limits the result based on the provided limit.
  /// Returns a list of [ProductModel] objects.
  Future<List<ProductModel>> getProductsForBrand(
    String brandId,
    int limit,
  ) async {
    try {
      final snapshot =
          await _db
              .collection('Sellers')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('seller_products')
              .where('brand', isEqualTo: brandId)
              .limit(limit)
              .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> searchProducts(
    String query, {
    String? categoryId,
    String? brandId,
    double? minPrice,
    double? maxPrice,
  }) async {
    try {
      Query queryRef = _db
          .collection('Sellers')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('seller_products');

      if (query.isNotEmpty) {
        queryRef = queryRef
            .where('title', isGreaterThanOrEqualTo: query)
            .where('title', isLessThanOrEqualTo: '$query\uf8ff');
      }

      if (categoryId != null) {
        queryRef = queryRef.where('category', isEqualTo: categoryId);
      }

      if (brandId != null) {
        queryRef = queryRef.where('brand', isEqualTo: brandId);
      }

      if (minPrice != null) {
        queryRef = queryRef.where('price', isGreaterThanOrEqualTo: minPrice);
      }

      if (maxPrice != null) {
        queryRef = queryRef.where('price', isLessThanOrEqualTo: maxPrice);
      }

      final querySnapshot = await queryRef.get();
      return querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update any field in specific Collection
  Future<void> updateSingleField(
    String docId,
    Map<String, dynamic> json,
  ) async {
    try {
      await _db
          .collection('Sellers')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('seller_products')
          .doc(docId)
          .update(json);
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const BaakasFormatException();
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update product.
  Future<void> updateProduct(ProductModel product) async {
    try {
      await _db
          .collection('Sellers')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('seller_products')
          .doc(product.id)
          .update(product.toJson());
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const BaakasFormatException();
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload dummy data to the Cloud Firebase.
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      // Upload all the products along with their images
      final storage = Get.put(TFirebaseStorageService());

      // Get Product Brand
      final brandRepository = Get.put(BrandRepository());

      // Loop through each product
      for (var product in products) {
        // Extract the selected brand
        final brand = await brandRepository.getSingleBrand(product.brand!.id);

        // Upload Brand image if Brand Not found
        if (brand == null || brand.image.isEmpty) {
          throw 'No Brands found. Please upload brands first.';
        } else {
          product.brand!.image = brand.image;
        }

        // Get image data link from local assets
        final thumbnail = await storage.getImageDataFromAssets(
          product.thumbnail,
        );

        // Upload image and get its URL
        final url = await storage.uploadImageData(
          'Products',
          thumbnail,
          path.basename(product.thumbnail),
          MediaCategory.products.name,
        );

        // Assign URL to product.thumbnail attribute
        product.thumbnail = url;

        // Product list of images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imagesUrl = [];
          for (var image in product.images!) {
            // Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(image);

            // Upload image and get its URL
            final url = await storage.uploadImageData(
              'Products',
              assetImage,
              path.basename(image),
              MediaCategory.products.name,
            );

            // Assign URL to product.thumbnail attribute
            imagesUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imagesUrl);
        }

        // Upload Variation Images
        if (product.productType == ProductType.variable.toString()) {
          for (var variation in product.productVariations!) {
            // Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(
              variation.image,
            );

            // Upload image and get its URL
            final url = await storage.uploadImageData(
              'Products',
              assetImage,
              path.basename(variation.image),
              MediaCategory.products.name,
            );

            // Assign URL to variation.image attribute
            variation.image = url;
          }
        }

        // Store product in Firestore
        await _db.collection("Products").doc(product.id).set(product.toJson());
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _db
          .collection('Sellers')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('seller_products')
          .doc(productId)
          .delete();
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
