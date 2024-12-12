import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  String _currentLanguage = 'en'; // default language

  String get currentLanguage => _currentLanguage;

  // Method to toggle the language
  void toggleLanguage(int index) {
    _currentLanguage = index == 0 ? 'en' : 'ms'; // 'en' for English, 'ms' for Bahasa Malaysia
    notifyListeners();
  }
}
