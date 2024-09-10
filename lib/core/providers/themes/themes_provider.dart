import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemesProvider extends ChangeNotifier {
  static const savedThemeKey = "newsTheme";
  ThemeMode currentThemeMode = ThemeMode.system;

  /*
  Indexes:
  0 => light
  1 => dark
  3 => system
  */

  final SharedPreferences sharedPreferences;

  ThemesProvider({required this.sharedPreferences}) {
    currentThemeMode =
        determineThemeMode(sharedPreferences.getInt(savedThemeKey));
  }

  void changeTheme(int? themeIndex) {
    currentThemeMode = determineThemeMode(themeIndex);
    notifyListeners();
    sharedPreferences.setInt(savedThemeKey, themeIndex ?? 2);
  }

  ThemeMode determineThemeMode(int? themeIndex) {
    return themeIndex == 0
        ? ThemeMode.light
        : themeIndex == 1
            ? ThemeMode.dark
            : ThemeMode.system;
  }

  int determineThemeName(ThemeMode themeMode) {
    return themeMode == ThemeMode.light
        ? 0
        : themeMode == ThemeMode.dark
            ? 1
            : 2;
  }

  bool isDark() {
    return currentThemeMode == ThemeMode.dark;
  }
}
