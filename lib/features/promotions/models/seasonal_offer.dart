import 'package:cloud_firestore/cloud_firestore.dart';

class SeasonalOffer {
  final String? id;
  final String title;
  final String description;
  final double discount;
  final DateTime startDate;
  final DateTime endDate;
  final String type;
  final List<String> applicableCategories;
  final bool isActive;
  final double minimumPurchase;

  SeasonalOffer({
    this.id,
    required this.title,
    required this.description,
    required this.discount,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.applicableCategories,
    required this.minimumPurchase,
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'discount': discount,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'type': type,
      'applicableCategories': applicableCategories,
      'isActive': isActive,
      'minimumPurchase': minimumPurchase,
    };
  }

  factory SeasonalOffer.fromMap(Map<String, dynamic> map, String id) {
    return SeasonalOffer(
      id: id,
      title: map['title'] as String,
      description: map['description'] as String,
      discount: (map['discount'] as num).toDouble(),
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: (map['endDate'] as Timestamp).toDate(),
      type: map['type'] as String,
      applicableCategories: List<String>.from(map['applicableCategories']),
      isActive: map['isActive'] as bool? ?? true,
      minimumPurchase: (map['minimumPurchase'] as num?)?.toDouble() ?? 0.0,
    );
  }

  SeasonalOffer copyWith({
    String? id,
    String? title,
    String? description,
    double? discount,
    DateTime? startDate,
    DateTime? endDate,
    String? type,
    List<String>? applicableCategories,
    bool? isActive,
    double? minimumPurchase,
  }) {
    return SeasonalOffer(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      discount: discount ?? this.discount,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      type: type ?? this.type,
      applicableCategories: applicableCategories ?? this.applicableCategories,
      isActive: isActive ?? this.isActive,
      minimumPurchase: minimumPurchase ?? this.minimumPurchase,
    );
  }
}
