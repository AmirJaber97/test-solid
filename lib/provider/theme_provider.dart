import 'package:flutter/material.dart';
import 'package:testsolid/cache/shared_preferences_helper.dart';
import 'package:testsolid/core/logger.dart';

class ThemeProvider extends ChangeNotifier {
  SharedPreferenceHelper _sharedPrefsHelper;

  final logger = getLogger('ThemeProvider');

  bool _isDarkModeOn = false;

  ThemeProvider() {
    _sharedPrefsHelper = SharedPreferenceHelper();
  }

  bool get isDarkModeOn {
    _sharedPrefsHelper.isDarkMode.then((statusValue) {
      _isDarkModeOn = statusValue;
    });

    return _isDarkModeOn;
  }

  void updateTheme(bool darkMode) {
    _sharedPrefsHelper.changeTheme(darkMode);
    _sharedPrefsHelper.isDarkMode.then((darkModeStatus) {
      _isDarkModeOn = darkModeStatus;
    });
    logger.i('Changing dark mode to ${darkMode ? 'Dark' : 'Light'}');

    notifyListeners();
  }
}
