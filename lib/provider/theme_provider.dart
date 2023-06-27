import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  void setTheme(bool dark) {
    _isDark = dark;
    notifyListeners();
  }
}
