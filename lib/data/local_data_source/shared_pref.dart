import 'package:erb_mobo/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late String token;
  static late User user;
  static late SharedPreferences _preferences;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static void setToken(String token) {
    _preferences.setString('token', token);
  }

  static String? getToken() => _preferences.getString('token');

  static void logOut() => _preferences.clear();
}
