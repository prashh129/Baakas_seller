import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/coupon_creation_dialog.dart';
import '../widgets/seasonal_offer_dialog.dart';

class PromotionsController extends GetxController {
  static PromotionsController get instance => Get.find();

  final RxInt selectedTab = 0.obs;
  final RxList<Coupon> coupons = <Coupon>[].obs;
  final RxList<SeasonalOffer> seasonalOffers = <SeasonalOffer>[].obs;
  final RxBool isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    loadCoupons();
    fetchSeasonalOffers();
  }

  void createNewCoupon() {
    Get.dialog(const CouponCreationDialog());
  }

  void createNewSeasonalOffer() {
    Get.dialog(const SeasonalOfferDialog());
  }

  // Load coupons from Firestore
  Future<void> loadCoupons() async {
    final sellerId = _auth.currentUser?.uid;
    if (sellerId == null) return;

    try {
      final snapshot =
          await _firestore
              .collection('Sellers')
              .doc(sellerId)
              .collection('coupons')
              .get();

      coupons.value =
          snapshot.docs
              .map((doc) => Coupon.fromMap(doc.id, doc.data()))
              .toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load coupons: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> fetchSeasonalOffers() async {
    try {
      isLoading.value = true;
      final sellerId = _auth.currentUser?.uid;
      if (sellerId == null) return;

      final snapshot =
          await _firestore
              .collection('Sellers')
              .doc(sellerId)
              .collection('seasonal_offers')
              .get();

      seasonalOffers.value =
          snapshot.docs
              .map((doc) => SeasonalOffer.fromMap(doc.data(), doc.id))
              .toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch seasonal offers: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Create a new coupon
  Future<void> createCoupon(Coupon coupon) async {
    final sellerId = _auth.currentUser?.uid;
    if (sellerId == null) return;

    try {
      await _firestore
          .collection('Sellers')
          .doc(sellerId)
          .collection('coupons')
          .add(coupon.toMap());

      await loadCoupons();
      Get.back();
      Get.snackbar(
        'Success',
        'Coupon created successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF4CAF50),
        colorText: const Color(0xFFFFFFFF),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create coupon: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFF44336),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }

  Future<void> createSeasonalOffer(SeasonalOffer offer) async {
    try {
      isLoading.value = true;
      final sellerId = _auth.currentUser?.uid;
      if (sellerId == null) {
        throw Exception('User not authenticated');
      }

      final docRef = await _firestore
          .collection('Sellers')
          .doc(sellerId)
          .collection('seasonal_offers')
          .add(offer.toMap());

      final newOffer = offer.copyWith(id: docRef.id);
      seasonalOffers.add(newOffer);

      Get.back(); // Close the dialog
      Get.snackbar(
        'Success',
        'Seasonal offer created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create seasonal offer: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateSeasonalOffer(SeasonalOffer offer) async {
    try {
      if (offer.id == null) return;

      isLoading.value = true;
      final sellerId = _auth.currentUser?.uid;
      if (sellerId == null) {
        throw Exception('User not authenticated');
      }

      await _firestore
          .collection('Sellers')
          .doc(sellerId)
          .collection('seasonal_offers')
          .doc(offer.id)
          .update(offer.toMap());

      final index = seasonalOffers.indexWhere(
        (element) => element.id == offer.id,
      );
      if (index != -1) {
        seasonalOffers[index] = offer;
      }

      Get.snackbar(
        'Success',
        'Seasonal offer updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update seasonal offer: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Delete a coupon
  Future<void> deleteCoupon(String couponId) async {
    final sellerId = _auth.currentUser?.uid;
    if (sellerId == null) return;

    try {
      await _firestore
          .collection('Sellers')
          .doc(sellerId)
          .collection('coupons')
          .doc(couponId)
          .delete();

      await loadCoupons();
      Get.snackbar(
        'Success',
        'Coupon deleted successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF4CAF50),
        colorText: const Color(0xFFFFFFFF),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete coupon: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFF44336),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }

  Future<void> deleteSeasonalOffer(String offerId) async {
    try {
      isLoading.value = true;
      final sellerId = _auth.currentUser?.uid;
      if (sellerId == null) {
        throw Exception('User not authenticated');
      }

      await _firestore
          .collection('Sellers')
          .doc(sellerId)
          .collection('seasonal_offers')
          .doc(offerId)
          .delete();

      seasonalOffers.removeWhere((offer) => offer.id == offerId);

      Get.snackbar(
        'Success',
        'Seasonal offer deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete seasonal offer: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

class Coupon {
  final String? id;
  final String code;
  final double discount;
  final DateTime expiryDate;
  final int usageLimit;
  final int usedCount;
  final String type; // percentage or fixed
  final List<String> applicableProducts; // List of product IDs
  final double minimumPurchase;
  final bool isActive;

  Coupon({
    this.id,
    required this.code,
    required this.discount,
    required this.expiryDate,
    required this.usageLimit,
    this.usedCount = 0,
    required this.type,
    required this.applicableProducts,
    required this.minimumPurchase,
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'discount': discount,
      'expiryDate': Timestamp.fromDate(expiryDate),
      'usageLimit': usageLimit,
      'usedCount': usedCount,
      'type': type,
      'applicableProducts': applicableProducts,
      'minimumPurchase': minimumPurchase,
      'isActive': isActive,
    };
  }

  static Coupon fromMap(String id, Map<String, dynamic> map) {
    return Coupon(
      id: id,
      code: map['code'] ?? '',
      discount: (map['discount'] ?? 0.0).toDouble(),
      expiryDate: (map['expiryDate'] as Timestamp).toDate(),
      usageLimit: map['usageLimit'] ?? 0,
      usedCount: map['usedCount'] ?? 0,
      type: map['type'] ?? 'percentage',
      applicableProducts: List<String>.from(map['applicableProducts'] ?? []),
      minimumPurchase: (map['minimumPurchase'] ?? 0.0).toDouble(),
      isActive: map['isActive'] ?? true,
    );
  }
}

class SeasonalOffer {
  final String? id;
  final String title;
  final double discount;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final List<String> applicableCategories;
  final bool isActive;
  final String type; // percentage or fixed
  final double minimumPurchase;

  SeasonalOffer({
    this.id,
    required this.title,
    required this.discount,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.applicableCategories,
    this.isActive = true,
    required this.type,
    required this.minimumPurchase,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'discount': discount,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'description': description,
      'applicableCategories': applicableCategories,
      'isActive': isActive,
      'type': type,
      'minimumPurchase': minimumPurchase,
    };
  }

  SeasonalOffer copyWith({
    String? id,
    String? title,
    double? discount,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
    List<String>? applicableCategories,
    bool? isActive,
    String? type,
    double? minimumPurchase,
  }) {
    return SeasonalOffer(
      id: id ?? this.id,
      title: title ?? this.title,
      discount: discount ?? this.discount,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      applicableCategories: applicableCategories ?? this.applicableCategories,
      isActive: isActive ?? this.isActive,
      type: type ?? this.type,
      minimumPurchase: minimumPurchase ?? this.minimumPurchase,
    );
  }

  static SeasonalOffer fromMap(Map<String, dynamic> map, String id) {
    return SeasonalOffer(
      id: id,
      title: map['title'] ?? '',
      discount: (map['discount'] ?? 0.0).toDouble(),
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: (map['endDate'] as Timestamp).toDate(),
      description: map['description'] ?? '',
      applicableCategories: List<String>.from(
        map['applicableCategories'] ?? [],
      ),
      isActive: map['isActive'] ?? true,
      type: map['type'] ?? 'percentage',
      minimumPurchase: (map['minimumPurchase'] ?? 0.0).toDouble(),
    );
  }
}
