import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wealthwatch/themes/dark_mode.dart';
import 'package:wealthwatch/themes/light_mode.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeData _themeData;

  ThemeProvider({bool isDarkMode = false}) {
    _themeData = isDarkMode ? darkMode : lightMode;
  }

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  Future<void> toggleTheme() async {
    _themeData = _themeData == lightMode ? darkMode : lightMode;
    notifyListeners();
    // Save the theme preference
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _themeData == darkMode);
  }
}
