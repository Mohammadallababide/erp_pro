import 'package:erb_mobo/data/local_data_source/shared_pref_sympoles_enum.dart';
import 'package:erb_mobo/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences _preferences;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static String? getToken() => _preferences
      .getString('${SharedPrefSympoles.token.toString().split('.')[1]}');
  static int? getUserId() => _preferences
      .getInt('${SharedPrefSympoles.userId.toString().split('.')[1]}');
  static String? getUserFirtsName() => _preferences
      .getString('${SharedPrefSympoles.firstName.toString().split('.')[1]}');
  static String? getUserLastName() => _preferences
      .getString('${SharedPrefSympoles.lastName.toString().split('.')[1]}');
  static String? getUserEmail() => _preferences
      .getString('${SharedPrefSympoles.userEmail.toString().split('.')[1]}');
  static int? getUserJobId() => _preferences
      .getInt('${SharedPrefSympoles.jobId.toString().split('.')[1]}');
  static String? getUserLevel() => _preferences
      .getString('${SharedPrefSympoles.level.toString().split('.')[1]}');
  static int? getUserDepartmentId() => _preferences
      .getInt('${SharedPrefSympoles.departmentId.toString().split('.')[1]}');

  static void setToken(String token) {
    _preferences.setString('token', token);
  }

  static void setUserId(int userId) {
    _preferences.setInt(
        '${SharedPrefSympoles.userId.toString().split('.')[1]}', userId);
  }

  static void setUserFirstName(String firstName) {
    _preferences.setString(
        '${SharedPrefSympoles.firstName.toString().split('.')[1]}', firstName);
  }

  static void setUserLastName(String lastName) {
    _preferences.setString(
      '${SharedPrefSympoles.lastName.toString().split('.')[1]}',
      lastName,
    );
  }

  static void setUserDepartmentId(int departmentId) {
    _preferences.setInt(
        '${SharedPrefSympoles.departmentId.toString().split('.')[1]}',
        departmentId);
  }

  static void setUserJobId(int jobId) {
    _preferences.setInt(
        '${SharedPrefSympoles.jobId.toString().split('.')[1]}', jobId);
  }

  static void setUserEmail(String userEmail) {
    _preferences.setString(
        '${SharedPrefSympoles.userEmail.toString().split('.')[1]}', userEmail);
  }

  static void setUserLevel(String levelId) {
    _preferences.setString(
        '${SharedPrefSympoles.level.toString().split('.')[1]}', levelId);
  }

  static User getUser() {
    return User(
      email: getUserEmail()!,
      firstName: getUserFirtsName()!,
      lastName: getUserLastName()!,
      id: getUserId(),
      departmentId: getUserDepartmentId(),
      level: getUserLevel(),
      jobId: getUserJobId(),
    );
  }

  static void logOut() => _preferences.clear();
}
