import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization_app/localization/supported_languages.dart';

class AppLocalization {
  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<dynamic> load(locale) async {
    // Load the language JSON file from the "lang" folder
    // print("DATAAA" + 'assets/language/${locale.languageCode}.json');
    String jsonString = await rootBundle
        .loadString('assets/language/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings[key] ?? "Missing Localized String";
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return supportedLanguages.contains(locale.languageCode) ||
        supportedLanguages.contains(locale);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalization localizations = new AppLocalization();
    await localizations.load(locale);
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => true;
}
