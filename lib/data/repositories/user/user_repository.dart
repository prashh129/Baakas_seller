import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../../../features/personalization/models/user_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../authentication/authentication_repository.dart';
import 'package:flutter/foundation.dart';

/// Repository class for user-related operations.
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _firebaseStorage = FirebaseStorage.instance;

  /// Function to save user data to Firestore.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Sellers").doc(user.id).set(user.toJson());
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

  /// Function to fetch user details based on user ID.
  Future<UserModel> fetchUserDetails() async {
    try {
      final userId = AuthenticationRepository.instance.getUserID;
      debugPrint('Attempting to fetch user details for ID: $userId');
      
      if (userId.isEmpty) {
        debugPrint('Error: User ID is empty');
        throw 'Unable to find user information.';
      }

      debugPrint('Querying Firestore collection: Sellers, document: $userId');
      final userSnapshot = await _db.collection('Sellers').doc(userId).get();
      
      if (!userSnapshot.exists) {
        debugPrint('Error: No document found for user ID: $userId');
        throw 'User not found.';
      }

      debugPrint('Document found, data: ${userSnapshot.data()}');
      return UserModel.fromSnapshot(userSnapshot);
    } catch (e) {
      debugPrint('Exception in fetchUserDetails: $e');
      throw 'Something went wrong while fetching user information. $e';
    }
  }

  /// Function to update user data in Firestore.
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("Sellers")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
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

  /// Update any field in specific Users Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Sellers")
          .doc(AuthenticationRepository.instance.getUserID)
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

  /// Upload any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = _firebaseStorage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
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

  /// Function to remove user data from Firestore.
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Sellers").doc(userId).delete();
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
}
