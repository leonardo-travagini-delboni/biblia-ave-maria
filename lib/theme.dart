import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  primaryColor: Colors.blue,
  canvasColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.grey[100],
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  primaryColor: Colors.black,
  canvasColor: Colors.grey[900],
  scaffoldBackgroundColor: Colors.grey[800],
  cardColor: Colors.grey[800],
);

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = lightTheme;

  ThemeData get theme => _theme;

  ThemeProvider() {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    _theme = isDark ? darkTheme : lightTheme;
    notifyListeners();
  }

  Future<void> switchTheme() async {
    final isDarkMode = _theme == darkTheme;
    _theme = isDarkMode ? lightTheme : darkTheme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', !isDarkMode);
    notifyListeners();
  }
}
