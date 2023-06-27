import 'package:flutter/material.dart';
import 'package:libraryprox_remote/l10n/l10n.dart';

class LocalProvider extends ChangeNotifier {
  Locale? _locale;
  Locale? get local => _locale;

  void setLocal(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void clearLocal() {
    _locale = null;
    notifyListeners();
  }
}
