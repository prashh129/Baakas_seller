import 'package:get/get.dart';
import '../models/category_model.dart';
import '../../../data/repositories/categories/category_repository.dart';
import 'package:logger/logger.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  final RxBool isLoading = true.obs;
  final _logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _logger.i('CategoryController initialized');
    // Initialize the CategoryRepository
    Get.put(CategoryRepository());
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      _logger.i('Starting to load categories...');
      isLoading.value = true;
      final categoryRepository = CategoryRepository.instance;
      final loadedCategories = await categoryRepository.getAllCategories();
      _logger.i('Loaded ${loadedCategories.length} categories');
      _logger.i('First category name: ${loadedCategories.isNotEmpty ? loadedCategories.first.name : "No categories"}');
      categories.value = loadedCategories;
      _logger.i('Categories list updated with ${categories.length} items');
    } catch (e) {
      _logger.e('Error loading categories: $e');
    } finally {
      isLoading.value = false;
      _logger.i('Loading completed. Categories count: ${categories.length}');
    }
  }

  void toggleCategory(CategoryModel category) {
    _logger.i('Toggling category: ${category.name}');
    final index = selectedCategories.indexWhere((selected) => selected.id == category.id);
    
    print('DEBUG: Category ID: ${category.id}');
    print('DEBUG: Selected categories count: ${selectedCategories.length}');
    print('DEBUG: Found at index: $index');
    
    if (index >= 0) {
      selectedCategories.removeAt(index);
      _logger.i('Category removed from selection');
      print('DEBUG: Category removed. New count: ${selectedCategories.length}');
    } else {
      selectedCategories.add(category);
      _logger.i('Category added to selection');
      print('DEBUG: Category added. New count: ${selectedCategories.length}');
    }
    
    // Force UI update
    selectedCategories.refresh();
  }

  bool isCategorySelected(CategoryModel category) {
    final isSelected = selectedCategories.any((selected) => selected.id == category.id);
    print('DEBUG: Checking if ${category.name} (${category.id}) is selected: $isSelected');
    return isSelected;
  }
} 