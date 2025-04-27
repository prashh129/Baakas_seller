import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/formatters/formatter.dart';
import 'address_model.dart';

/// Model class representing user data.
class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String username;
  final String phoneNumber;
  final String? profilePicture;
  final String address;
  final AppRole role;
  final bool isEmailVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? bio;
  final String? website;
  final Map<String, String> socialLinks;
  final Map<String, String> preferences;

  const UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phoneNumber,
    this.profilePicture,
    required this.address,
    required this.role,
    required this.isEmailVerified,
    required this.createdAt,
    required this.updatedAt,
    this.bio,
    this.website,
    required this.socialLinks,
    required this.preferences,
  });

  /// Helper function to get the full name.
  String get fullName => '$firstName $lastName';

  /// Helper function to format phone number.
  String get formattedPhoneNo => BaakasFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name into first and last name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Static function to generate a username from the full name.
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername";
    return usernameWithPrefix;
  }

  /// Static function to create an empty user model.
  static UserModel empty() => UserModel(
    id: '',
    firstName: '',
    lastName: '',
    username: '',
    email: '',
    phoneNumber: '',
    profilePicture: null,
    address: '',
    role: AppRole.seller,
    isEmailVerified: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    bio: null,
    website: null,
    socialLinks: {},
    preferences: {},
  );

  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Role': role.name,
      'Gender': '',
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt,
      'DateOfBirth': '',
    };
  }

  /// Create a UserModel from a Firestore document snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final logger = Logger();

    try {
      logger.i('Creating UserModel from Firestore document: ${snapshot.id}');
      
      // Parse required fields
      final id = snapshot.id;
      final email = data['email'] as String? ?? '';
      final firstName = data['firstName'] as String? ?? '';
      final lastName = data['lastName'] as String? ?? '';
      final username = data['username'] as String? ?? '';
      final phoneNumber = data['phoneNumber'] as String? ?? '';
      final profilePicture = data['profilePicture'] as String?;
      final address = data['address'] as String? ?? '';
      final role = data['role'] != null ? AppRole.values.firstWhere(
        (role) => role.name == data['role'],
        orElse: () => AppRole.seller,
      ) : AppRole.seller;
      final isEmailVerified = data['isEmailVerified'] as bool? ?? false;
      final createdAt = (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
      final updatedAt = (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now();

      // Parse optional fields with null safety
      final bio = data['bio'] as String?;
      final website = data['website'] as String?;
      final socialLinks = (data['socialLinks'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value.toString()),
      ) ?? {};
      
      final preferences = (data['preferences'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value.toString()),
      ) ?? {};

      logger.i('Successfully parsed user data for: $email');

      return UserModel(
        id: id,
        email: email,
        firstName: firstName,
        lastName: lastName,
        username: username,
        phoneNumber: phoneNumber,
        profilePicture: profilePicture,
        address: address,
        role: role,
        isEmailVerified: isEmailVerified,
        createdAt: createdAt,
        updatedAt: updatedAt,
        bio: bio,
        website: website,
        socialLinks: socialLinks,
        preferences: preferences,
      );
    } catch (e, stackTrace) {
      logger.e('Error parsing user data from Firestore', error: e, stackTrace: stackTrace);
      throw 'Failed to parse user data: $e';
    }
  }
}
