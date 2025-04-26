import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      print('Starting to fetch categories...');
      
      final snapshot = await _db.collection('Categories')
          .orderBy('Name')
          .get();
      
      print('Number of documents: ${snapshot.docs.length}');
      
      categories.value = snapshot.docs
          .map((doc) => CategoryModel.fromFirestore(doc))
          .toList();
      
      print('Processed categories: ${categories.length}');
      print('Category names: ${categories.map((c) => c.name).toList()}');
    } catch (e) {
      print('Error fetching categories: $e');
      print('Error details: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleCategory(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  bool isCategorySelected(CategoryModel category) {
    return selectedCategories.contains(category);
  }
} 