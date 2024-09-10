import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalesProvider extends ChangeNotifier {
  static const String savedLocaleKey = "newsLocale";
  final List<String> locales = ["English", "العربية"];

  String currentLocale = "en";

  SharedPreferences sharedPreferences;

  LocalesProvider({required this.sharedPreferences}) {
    currentLocale = sharedPreferences.getString(savedLocaleKey) ?? "en";
  }

  static AppLocalizations getTrans(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  void changeLocale(String? localeCode) {
    currentLocale = localeCode ?? "en";
    notifyListeners();
    sharedPreferences.setString(savedLocaleKey, localeCode ?? "en");
  }

  bool isArabic() {
    return currentLocale == "ar";
  }
}
