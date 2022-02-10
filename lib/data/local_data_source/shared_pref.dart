// import 'package:erb_mobo/models/user.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPref {
//   static late String token;
//   static late User user;
//   static late Future<SharedPreferences> _preferences ;
//   static Future init() async =>
//       _preferences = (await SharedPreferences.getInstance()) as Future<SharedPreferences>;

//   static Future setToken(String token) async {
//     await _preferences.then((pref) => pref.setString('token', token) );
//   }

//   static Future<String>? getToken() => _preferences.then((pref) => pref.getString('token')!);
// }
