import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  Locale _locale = Locale('en');

  void setLocale(Locale locale) {
    this._locale = locale;
    notifyListeners();
  }

  Locale get getLocale => this._locale;
}
