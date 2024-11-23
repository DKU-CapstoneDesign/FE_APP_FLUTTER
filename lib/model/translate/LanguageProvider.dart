import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _selectedLanguage = 'ko'; // 기본 언어: 한국어

  String get selectedLanguage => _selectedLanguage;

  void changeLanguage(String languageCode) {
    _selectedLanguage = languageCode;
    notifyListeners();
  }
}
