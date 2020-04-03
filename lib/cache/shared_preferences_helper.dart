import 'package:shared_preferences/shared_preferences.dart';
import 'package:testsolid/core/logger.dart';

class SharedPreferenceHelper {
  final logger = getLogger('SharedPreferenceHelper');

  Future<SharedPreferences> _sharedPreference;
  static const String is_dark_mode = "is_dark_mode";

  SharedPreferenceHelper() {
    _sharedPreference = SharedPreferences.getInstance();
  }

  Future<void> clearPreferences() {
    return _sharedPreference.then((prefs) => prefs.clear());
  }

  //Theme module
  Future<void> changeTheme(bool value) {
    return _sharedPreference.then((prefs) {
      return prefs.setBool(is_dark_mode, value);
    });
  }

  Future<bool> get isDarkMode {
    return _sharedPreference.then((prefs) {
      return prefs.getBool(is_dark_mode) ?? false;
    });
  }
}
