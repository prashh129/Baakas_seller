import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import '../../../utils/translations/en_US.dart';
import '../../../utils/translations/ne_NP.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS,
    'ne_NP': neNP,
    'hi_IN': {}, // Add Hindi translations when available
  };
}

class LanguageController extends GetxController {
  static LanguageController get instance => Get.find();

  final _storage = GetStorage();
  final String _key = 'language';

  final RxString selectedLanguage = 'English'.obs;
  final RxString selectedLanguageCode = 'en'.obs;

  final List<String> languages = ['English', 'हिंदी', 'नेपाली'];
  final List<String> languageCodes = ['en', 'hi', 'ne'];

  // Map to store original text casing

  @override
  void onInit() {
    super.onInit();
    _loadLanguage();
  }

  void _loadLanguage() {
    final language = _storage.read(_key);
    if (language != null) {
      selectedLanguage.value = language;
      final index = languages.indexOf(selectedLanguage.value);
      if (index != -1) {
        selectedLanguageCode.value = languageCodes[index];
        _updateLocale(selectedLanguage.value);
      }
    }
  }

  void changeLanguage(String language) {
    _storage.write(_key, language);
    selectedLanguage.value = language;
    _updateLocale(language);
  }

  void _updateLocale(String language) {
    switch (language) {
      case 'English':
        selectedLanguageCode.value = 'en';
        Get.updateLocale(const Locale('en', 'US'));
        break;
      case 'हिंदी':
        selectedLanguageCode.value = 'hi';
        Get.updateLocale(const Locale('hi', 'IN'));
        break;
      case 'नेपाली':
        selectedLanguageCode.value = 'ne';
        Get.updateLocale(const Locale('ne', 'NP'));
        break;
    }
  }

  String translate(String text) {
    if (selectedLanguageCode.value == 'ne') {
      // Map of exact text to Nepali translations
      final translations = {
        'Account': 'खाता',
        'Account Settings': 'खाता सेटिङ',
        'Document': 'कागजात',
        'Insert or edit your document': 'कागजात सम्पादन गर्नुहोस्',
        'Language': 'भाषा',
        'Select Language': 'भाषा चयन गर्नुहोस्',
        'Please select your language': 'कृपया आफ्नो भाषा चयन गर्नुहोस्',
        'My Addresses': 'मेरो ठेगानाहरू',
        'Set shopping delivery address': 'किनमेल ठेगाना सेट गर्नुहोस्',
        'Orders Details': 'अर्डर विवरणहरू',
        'In-progress and Completed Orders': 'चालु र सकिएका अर्डरहरू',
        'Bank Account': 'बैंक खाता',
        'Withdraw balance to registered bank account':
            'बैंक खाताबाट रकम झिक्नुहोस्',
        'Notifications': 'सूचनाहरू',
        'Set any kind of notification message': 'सूचना सन्देश सेट गर्नुहोस्',
        'Account Privacy': 'खाता गोपनीयता',
        'Manage data usage and connected accounts':
            'डाटा प्रयोग प्रबन्ध गर्नुहोस्',
        'App Settings': 'एप सेटिङ्स',
        'Load Data': 'डाटा लोड गर्नुहोस्',
        'Upload Data to your Cloud Firebase': 'फायरबेसमा डाटा अपलोड गर्नुहोस्',
        'Geolocation': 'भौगोलिक स्थान',
        'Set recommendation based on location':
            'स्थान आधारित सिफारिस सेट गर्नुहोस्',
        'Safe Mode': 'सुरक्षित मोड',
        'Search result is safe for all ages': 'सबै उमेरका लागि सुरक्षित खोजी',
        'HD Image Quality': 'एचडी गुणस्तर',
        'Set image quality to be seen': 'तस्बिर गुणस्तर सेट गर्नुहोस्',
        'Logout': 'लग आउट',
      };
      return translations[text] ?? text;
    }
    return text;
  }

  bool isSelected(String language) {
    return selectedLanguage.value == language;
  }

  String getCurrentLanguage() {
    return selectedLanguage.value;
  }

  String getCurrentLanguageCode() {
    return selectedLanguageCode.value;
  }
}
