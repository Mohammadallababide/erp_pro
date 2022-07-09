import 'dart:convert';
import 'dart:io';
import 'package:erb_mobo/data/local_data_source/shared_pref.dart';
import 'package:erb_mobo/models/appFile.dart';
import 'package:erb_mobo/models/department.dart';
import 'package:erb_mobo/models/salary.dart';
import 'package:erb_mobo/models/user.dart';
import 'package:http/http.dart' as http;

import '../../models/deduction.dart';
import '../../models/imageModel.dart';
import '../../models/invoice.dart';
import '../../models/job.dart';
import '../../models/leave.dart';
import '../../models/leaveCategory.dart';
import '../../models/receipt.dart';
import '../../models/salary-scale-job.dart';
import '../../models/salary-scale.dart';

class ServerApi {
  ServerApi._() {
    getLocalToken();
  }

  late String language;
  static String? accessToken;
  static final ServerApi apiClient = ServerApi._();
  static final http.Client _httpClient = http.Client();
  // static const _baseUrl = "https://ite-ria.herokuapp.com/api/v1";
  // static const _baseUrl = 'http://192.168.137.1:3000/api/v1';
  static const _baseUrl = 'http://192.168.1.5:3000/api/v1';

  Map<String, String> getHeaders() {
    print('Bearer ${getLocalToken().toString()}');
    return {
      'Authorization': 'Bearer ${getLocalToken()}',
      // 'Authorization':
      //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJyaWFAcmlhLmNvbSIsImlhdCI6MTY0OTczNDM1NiwiZXhwIjoxNjUwNTk4MzU2fQ.o00y7b8KSTh1s60cygedPdzMzSaR4GVht0k-Qaxtgj0',
      'content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
  }

  String? getLocalToken() {
    return SharedPref.getToken();
  }

  //Auth

  Future<ImageModel?> uploadImage(filepath) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(_baseUrl + '/app-files'));
      // request.fields['avatar'] = filepath;
      request.files.add(
        await http.MultipartFile.fromPath('avatar', filepath),
      );
      request.headers['authorization'] = 'Bearer ${getLocalToken()}';
      var res = await request.send();
      //  var image = http.MultipartFile.fromBytes(
      //       'avatar',
      //       (await rootBundle.load(
      //         'assets/uploadFiles/people1.jpg',
      //       ))
      //           .buffer
      //           .asInt8List(),
      //       filename: 'people1.jpg');
      //   request.files.add(image);
      //   var res = await request.send();
      //   print(res);
      //   var responseDate = await res.stream.toBytes();
      //   var result = String.fromCharCodes(responseDate);
      //   print('output is : ');
      //   print(responseDate);
      // print('RESPONSE HEADERS ...');
      // print(res.headers);
      // print('RESPONSE CONTENTLENGTH ...');
      // print(res.contentLength);
      // print('RESPONSE STREAM ...');
      // print(res.stream);
      // print('RESPONSE IS REDIRECT  ...');
      // print(res.isRedirect);
      // print('RESPONSE PERSISTENT CONTECTION ...');
      // print(res.persistentConnection);
      // print('RESPONSE REQUEST ...');
      // print(res.request);
      // print('RESPONSE STATUS CODE ...');
      // print(res.statusCode);
      if (res.statusCode == 200 || res.statusCode == 201) {
        var response = await http.Response.fromStream(res);
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        ImageModel image = ImageModel.fromJson(result['data']);
        return image;
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<AppFile?> getAppFile(int id) async {
    try {
      final uri = Uri.parse(_baseUrl + '/app-files/$id');
      final response = await _httpClient.get(
        uri,
        headers: getHeaders(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        AppFile file = AppFile.fromJson(json['data']);
        return file;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.get(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          AppFile file = AppFile.fromJson(json['data']);
          return file;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
    return null;
  }

  Future<void> refreshToken() async {
    try {
      final uri = Uri.parse(_baseUrl + '/auth/refresh?token=$accessToken');
      final response = await _httpClient.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        SharedPref.setToken(json['data']['refreshToken']);
        SharedPref.setUserId(json['data']['id']);
        SharedPref.setUserEmail(json['data']['email']);
        SharedPref.setUserFirstName(json['data']['firstName']);
        SharedPref.setUserLastName(json['data']['lastName']);
        SharedPref.setUserJobId(json['data']['jobId']);
        SharedPref.setUserLevel(json['data']['level']);
        SharedPref.setUserDepartmentId(json['data']['departmentId']);
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<List<Department>?> getDepartments() async {
    late List<Department> result;
    try {
      final uri = Uri.parse(_baseUrl + '/departments');
      final response = await _httpClient.get(
        uri,
        headers: getHeaders(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        result = (jsonData['data'] as List)
            .map((e) => Department.fromJson(e))
            .toList();
        return result;
      } else if (response.statusCode == 401) {
        await refreshToken();
        final jsonData = json.decode(response.body);
        result = (jsonData['data'] as List)
            .map((e) => Department.fromJson(e))
            .toList();
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<Department?> getDepartmentById(int id) async {
    late Department? result;
    try {
      final uri = Uri.parse(_baseUrl + '/departments/$id');
      final response = await _httpClient.get(
        uri,
        headers: getHeaders(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        result = Department.fromJson(jsonData['data']);
        return result;
      } else if (response.statusCode == 401) {
        await refreshToken();
        final jsonData = json.decode(response.body);
        result = jsonData['data'];
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<void> createDepartment({
    required String title,
    required int maxNumberOfEmployees,
  }) async {
    try {
      final uri = Uri.parse(_baseUrl + '/departments');
      Map<String, dynamic> body;
      body = {
        "title": title,
        "maxNumberOfEmployees": maxNumberOfEmployees,
      };

      final bodReq = jsonEncode(body);
      await _httpClient.post(
        uri,
        headers: getHeaders(),
        body: bodReq,
      );
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<Department?> editDepartment({
    required String title,
    required int maxNumberOfEmployees,
    required int id,
  }) async {
    try {
      final uri = Uri.parse(_baseUrl + '/departments/$id');
      Map<String, dynamic> body;
      body = {
        "title": title,
        "maxNumberOfEmployees": maxNumberOfEmployees,
      };

      final bodReq = jsonEncode(body);
      final response = await _httpClient.put(
        uri,
        headers: getHeaders(),
        body: bodReq,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final Department department = Department.fromJson(json['data']);
        return department;
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<void> addUsersToDepartment({
    required List<int> usersId,
    required int id,
  }) async {
    try {
      final uri =
          Uri.parse(_baseUrl + '/departments/$id/add-user-to-departments');
      Map<String, dynamic> body = {
        "ids": usersId,
        "overwrite": true,
      };
      final bodReq = jsonEncode(body);
      final response = await _httpClient.put(
        uri,
        headers: getHeaders(),
        body: bodReq,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final Department department = Department.fromJson(json['data']);
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<void> markUserAsMangerOfDepartment({
    required int userId,
    required int id,
  }) async {
    try {
      final uri = Uri.parse(_baseUrl + '/departments/$id/mark-user-as-manager');
      Map<String, dynamic> body = {"userId": userId};
      final bodReq = jsonEncode(body);
      final response = await _httpClient.put(
        uri,
        headers: getHeaders(),
        body: bodReq,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final Department department = Department.fromJson(json['data']);
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<User?> fetchMyProfile() async {
    try {
      final uri = Uri.parse(_baseUrl + '/users/me');
      final response = await _httpClient.get(
        uri,
        headers: getHeaders(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final User user = User.fromJson(json['data']);

        return user;
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<User?> signIn(
      {required String email, required String password}) async {
    try {
      final uri = Uri.parse(_baseUrl + '/auth/login');
      print(uri);
      Map<String, String> body = <String, String>{};
      body = {'email': email, 'password': password};
      final bodReq = jsonEncode(body);
      final response = await _httpClient.post(
        uri,
        body: bodReq,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final User user = User.fromJson(json['data']);
        if (json['data']['accessToken'] != null) {
          SharedPref.setToken(json['data']['accessToken']);
          SharedPref.setUserId(json['data']['id']);
          SharedPref.setUserEmail(json['data']['email']);
          SharedPref.setUserFirstName(json['data']['firstName']);
          SharedPref.setUserLastName(json['data']['lastName']);
          // SharedPref.setUserJobId(json['data']['jobId']);
          // SharedPref.setUserLevel(json['data']['level']);
          // SharedPref.setUserDepartmentId(json['data']['departmentId']);
        }
        return user;
      }
    } catch (e) {
      print(e.toString());
      // print(e);
      return Future.error(e.toString());
    }
  }

  Future<String> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      final uri = Uri.parse(_baseUrl + '/auth/sign-up');
      Map<String, dynamic> body = <String, dynamic>{};
      body = {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'avatarId': null
      };
      final bodReq = jsonEncode(body);
      final response = await _httpClient.post(
        uri,
        body: bodReq,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        return json['data']['message'];
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
    return '';
  }

  // For Addmin
  // ----------

  Future<List<User>?> getUsersRequestsSignupApprovment() async {
    late List<User> result;
    try {
      // await refreshToken();
      final uri = Uri.parse(
          _baseUrl + '/users/for-admin?isActive=false&isVerified=false');
      final response = await _httpClient.get(uri, headers: getHeaders());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        result =
            (jsonData['data'] as List).map((e) => User.fromJson(e)).toList();
        return result;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.get(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonData = json.decode(response.body);
          result =
              (jsonData['data'] as List).map((e) => User.fromJson(e)).toList();
          return result;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<List<User>?> getUsersApprovment() async {
    late List<User> result;
    try {
      // await refreshToken();
      final uri = Uri.parse(
          _baseUrl + '/users/for-admin?isActive=true&isVerified=true');
      final response = await _httpClient.get(uri, headers: getHeaders());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        result =
            (jsonData['data'] as List).map((e) => User.fromJson(e)).toList();
        return result;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.get(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonData = json.decode(response.body);
          result =
              (jsonData['data'] as List).map((e) => User.fromJson(e)).toList();
          return result;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<User?> approveSignupUser({
    required int userId,
    required int departmentId,
  }) async {
    try {
      final uri = Uri.parse(_baseUrl + '/auth-for-admin/approve-user');
      Map<String, dynamic> body;
      body = {
        "id": userId,
        "departmentId": departmentId,
      };

      final bodReq = jsonEncode(body);
      final response = await _httpClient.post(
        uri,
        headers: getHeaders(),
        body: bodReq,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final User user = User.fromJson(json['data']);
        return user;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final User user = User.fromJson(json['data']);
          return user;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<User?> rejectSignupUser(int userId) async {
    try {
      final uri = Uri.parse(_baseUrl + '/auth-for-admin/reject-user/$userId');
      final response = await _httpClient.post(uri, headers: getHeaders());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final User user = User.fromJson(json['data']);
        return user;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final User user = User.fromJson(json['data']);
          return user;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  // Salary Scales Apis ...
  Future<SalaryScale?> createSalaryScale(
      List<SalaryScaleJob> salaryScaleJobs) async {
    try {
      final uri = Uri.parse(_baseUrl + '/salary-scales');
      List<Map<String, dynamic>> salaryScaleJobList = salaryScaleJobs
          .map((e) => {
                "jobId": e.jobId,
                "amount": e.amount,
                "employeeLevel": e.employeeLevel,
              })
          .toList();

      Map<String, dynamic> body;
      body = {"entities": salaryScaleJobList};

      final bodReq = jsonEncode(body);
      final response = await _httpClient.post(
        uri,
        headers: getHeaders(),
        body: bodReq,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final SalaryScale salaryScale = SalaryScale.fromJson(json['data']);
        return salaryScale;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final SalaryScale salaryScale = SalaryScale.fromJson(json['data']);
          return salaryScale;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<List<SalaryScale>?> getSalaryScales([int page = 1]) async {
    late List<SalaryScale> salaryScales;
    try {
      final uri = Uri.parse(_baseUrl + '/salary-scales');
      final response = await _httpClient.get(uri, headers: getHeaders());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        salaryScales = (jsonData['data'] as List)
            .map((e) => SalaryScale.fromJson(e))
            .toList();
        return salaryScales;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.get(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonData = json.decode(response.body);
          salaryScales = (jsonData['data'] as List<SalaryScale>)
              .map((e) => SalaryScale.fromJson(e))
              .toList();
          return salaryScales;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<bool?> deleteSalaryScale(
    int id,
  ) async {
    try {
      final uri = Uri.parse(_baseUrl + '/salary-scales/$id');
      final response = await _httpClient.delete(
        uri,
        headers: getHeaders(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          return true;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<bool> activateSalaryScale(int id) async {
    try {
      final uri = Uri.parse(_baseUrl + '/salary-scales/$id/activate');
      Map<String, dynamic> body = <String, dynamic>{};

      final bodReq = jsonEncode(body);
      final response = await _httpClient.patch(
        uri,
        headers: getHeaders(),
        body: bodReq,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          return true;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
    return false;
  }

  // Invoices Api ...

  Future<List<Invoice>?> getInvoices([int page = 1, int limit = 1]) async {
    late List<Invoice> invoices = [];
    try {
      final uri = Uri.parse(_baseUrl + '/invoices/cruds');
      final response = await _httpClient.get(uri, headers: getHeaders());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        invoices =
            (jsonData['data'] as List).map((e) => Invoice.fromJson(e)).toList();
        print(invoices);
        return invoices;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.get(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonData = json.decode(response.body);
          invoices = (jsonData['data'] as List)
              .map((e) => Invoice.fromJson(e))
              .toList();
          return invoices;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<void> createIvoice(
      {required int grossAmount,
      required int netAmount,
      required String taxNumber,
      required String dueDate,
      required String issueDate,
      required String filepath}) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(_baseUrl + '/invoices/cruds'),
      );

      request.fields.addAll({
        "grossAmount": grossAmount.toString(),
        "netAmount": netAmount.toString(),
        "taxNumber": taxNumber,
        "dueDate": dueDate,
        "issueDate": issueDate
      });
      request.headers['authorization'] = 'Bearer ${getLocalToken()}';
      request.files.add(
        await http.MultipartFile.fromPath('invoice', filepath),
      );
      var res = await request.send();
      if (res.statusCode == 200 || res.statusCode == 201) {
        var response = await http.Response.fromStream(res);
        final result = jsonDecode(response.body) as Map<String, dynamic>;
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
    return null;
  }

  Future<bool?> deleteInvoice(
    int id,
  ) async {
    try {
      final uri = Uri.parse(_baseUrl + '/invoices/cruds/$id');
      final response = await _httpClient.delete(
        uri,
        headers: getHeaders(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          return true;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<Invoice?> assignInvoiceToUser({
    required int id,
    required int userId,
    required String assignmentNote,
  }) async {
    try {
      final uri = Uri.parse(_baseUrl + '/invoices/flow/$id/assign-to-user');
      Map<String, dynamic> body = <String, dynamic>{
        "userId": userId,
        "assignmentNote": assignmentNote
      };

      final bodReq = jsonEncode(body);
      final response = await _httpClient.post(
        uri,
        headers: getHeaders(),
        body: bodReq,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final Invoice inv = Invoice.fromJson(json['data']);
        return inv;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final Invoice inv = Invoice.fromJson(json['data']);
          return inv;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
    return null;
  }

  Future<Invoice?> unAssignInvoiceToUser({
    required int id,
    required int userId,
    required String assignmentNote,
  }) async {
    try {
      final uri =
          Uri.parse(_baseUrl + '/invoices/flow/$id/un-assign-from-user');
      Map<String, dynamic> body = <String, dynamic>{
        "userId": userId,
        "assignmentNote": assignmentNote
      };

      final bodReq = jsonEncode(body);
      final response = await _httpClient.post(
        uri,
        headers: getHeaders(),
        body: bodReq,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final Invoice inv = Invoice.fromJson(json['data']);
        return inv;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final Invoice inv = Invoice.fromJson(json['data']);
          return inv;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
    return null;
  }

  Future<Invoice?> reviewInvoice(
    int id,
  ) async {
    try {
      final uri = Uri.parse(_baseUrl + '/invoices/flow/$id/review');
      final response = await _httpClient.post(
        uri,
        headers: getHeaders(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final Invoice inv = Invoice.fromJson(json['data']);
        return inv;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final Invoice inv = Invoice.fromJson(json['data']);
          return inv;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
    return null;
  }

  Future<Invoice?> approveInvoice(
    int id,
  ) async {
    try {
      final uri = Uri.parse(_baseUrl + '/invoices/flow/$id/approve');

      final response = await _httpClient.post(
        uri,
        headers: getHeaders(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final Invoice inv = Invoice.fromJson(json['data']);
        return inv;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final Invoice inv = Invoice.fromJson(json['data']);
          return inv;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
    return null;
  }

  Future<Invoice?> rejectInvoice(
    int id,
  ) async {
    try {
      final uri = Uri.parse(_baseUrl + '/invoices/flow/$id/reject');

      final response = await _httpClient.post(
        uri,
        headers: getHeaders(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final Invoice inv = Invoice.fromJson(json['data']);
        return inv;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final Invoice inv = Invoice.fromJson(json['data']);
          return inv;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
    return null;
  }

  Future<Invoice?> markAsPaidInvoice(
    int id,
  ) async {
    try {
      final uri = Uri.parse(_baseUrl + '/invoices/flow/$id/mark-as-paid');

      final response = await _httpClient.post(
        uri,
        headers: getHeaders(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final Invoice inv = Invoice.fromJson(json['data']);
        return inv;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final Invoice inv = Invoice.fromJson(json['data']);
          return inv;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
    return null;
  }

  // Leave Apis ...
  Future<List<Leave>?> getLeaves() async {
    try {
      final uri = Uri.parse(_baseUrl + '/leaves');
      final response = await _httpClient.get(uri, headers: getHeaders());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        List<Leave> leaves =
            (jsonData['data'] as List).map((e) => Leave.fromJson(e)).toList();
        return leaves;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.get(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonData = json.decode(response.body);
          List<Leave> leaves =
              (jsonData['data'] as List).map((e) => Leave.fromJson(e)).toList();
          return leaves;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<Leave?> createLeaveRequest({
    required int leaveCategoryId,
    required String description,
    required String fromDate,
    required String toDate,
  }) async {
    try {
      final uri = Uri.parse(_baseUrl + '/leaves');
      Map<String, dynamic> body = <String, dynamic>{};
      body = {
        "leaveCategoryId": leaveCategoryId,
        "description": description,
        "fromDate": fromDate,
        "toDate": toDate,
      };
      final bodReq = jsonEncode(body);
      final response = await _httpClient.post(
        uri,
        headers: getHeaders(),
        body: bodReq,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final Leave leave = Leave.fromJson(json['data']);
        return leave;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final Leave leave = Leave.fromJson(json['data']);
          return leave;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
    return null;
  }

  Future<Leave?> approveLeaveRequest(int id) async {
    try {
      final uri = Uri.parse(_baseUrl + '/leaves/$id/approve');
      Map<String, dynamic> body = <String, dynamic>{};

      final response = await _httpClient.patch(
        uri,
        headers: getHeaders(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final Leave leave = Leave.fromJson(json['data']);
        return leave;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final Leave leave = Leave.fromJson(json['data']);
          return leave;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<Leave?> rejectLeaveRequest(int id) async {
    try {
      final uri = Uri.parse(_baseUrl + '/leaves/$id/reject');

      final response = await _httpClient.patch(
        uri,
        headers: getHeaders(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final Leave leave = Leave.fromJson(json['data']);
        return leave;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final Leave leave = Leave.fromJson(json['data']);
          return leave;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  // Leave Category Apis ...
  Future<List<LeaveCategory>?> getLeavesCategories() async {
    try {
      final uri = Uri.parse(_baseUrl + '/leaves-categories');
      final response = await _httpClient.get(uri, headers: getHeaders());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        List<LeaveCategory> leavesCategories = (jsonData['data'] as List)
            .map((e) => LeaveCategory.fromJson(e))
            .toList();
        return leavesCategories;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.get(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonData = json.decode(response.body);
          List<LeaveCategory> leavesCategories = (jsonData['data'] as List)
              .map((e) => LeaveCategory.fromJson(e))
              .toList();
          return leavesCategories;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<LeaveCategory?> createLeaveCategory({
    required int deductionAmount,
    required String name,
  }) async {
    try {
      final uri = Uri.parse(_baseUrl + '/leaves-categories');
      Map<String, dynamic> body = <String, dynamic>{};
      body = {
        "name": name,
        "deductionAmount": deductionAmount,
      };
      final bodReq = jsonEncode(body);
      final response = await _httpClient.post(
        uri,
        headers: getHeaders(),
        body: bodReq,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final LeaveCategory leaveCategory =
            LeaveCategory.fromJson(json['data']);
        return leaveCategory;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final LeaveCategory leaveCategory =
              LeaveCategory.fromJson(json['data']);
          return leaveCategory;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
    return null;
  }

  Future<bool?> deleteLeaveCategorie(
    int id,
  ) async {
    try {
      final uri = Uri.parse(_baseUrl + '/leaves-categories/$id');
      final response = await _httpClient.delete(
        uri,
        headers: getHeaders(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          return true;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }
  // job Apis ...
  Future<User?> assignJob({
    required int userId,
    required int jobId,
    required String level,
  }) async {
    try {
      final uri = Uri.parse(_baseUrl + '/users/for-admin/$userId/assign-job');
      Map<String, dynamic> body = <String, dynamic>{};
      body = {
        "jobId": jobId,
        "level": level,
      };
      final bodReq = jsonEncode(body);
      final response = await _httpClient.patch(
        uri,
        headers: getHeaders(),
        body: bodReq,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final User user = User.fromJson(json['data']);
        return user;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final User user = User.fromJson(json['data']);
          return user;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<List<Job>> getJobs([int page = 1]) async {
    late List<Job> jobs = [];
    try {
      final uri = Uri.parse(_baseUrl + '/jobs?page=$page');
      final response = await _httpClient.get(uri, headers: getHeaders());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        jobs = (jsonData['data'] as List).map((e) => Job.fromJson(e)).toList();
        return jobs;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.get(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonData = json.decode(response.body);
          jobs =
              (jsonData['data'] as List).map((e) => Job.fromJson(e)).toList();
          return jobs;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
    return jobs;
  }

  Future<Job?> createJob({
    required String name,
    required String description,
    required int departmentId,
  }) async {
    try {
      final uri = Uri.parse(_baseUrl + '/jobs');
      Map<String, dynamic> body = <String, dynamic>{};
      body = {
        "name": name,
        "description": description,
        "departmentId": departmentId,
      };
      final bodReq = jsonEncode(body);
      final response = await _httpClient.post(
        uri,
        headers: getHeaders(),
        body: bodReq,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final Job job = Job.fromJson(json['data']);
        return job;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final Job job = Job.fromJson(json['data']);
          return job;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
    return null;
  }

  Future<Job?> editJob({
    required int id,
    required String name,
    required String description,
  }) async {
    try {
      final uri = Uri.parse(_baseUrl + '/jobs/$id');
      Map<String, dynamic> body = <String, dynamic>{};
      body = {"name": name, "description": description};
      final bodReq = jsonEncode(body);
      final response = await _httpClient.put(
        uri,
        headers: getHeaders(),
        body: bodReq,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final Job job = Job.fromJson(json['data']);
        return job;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final Job job = Job.fromJson(json['data']);
          return job;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
    return null;
  }

  Future<bool?> deleteJob(
    int id,
  ) async {
    try {
      final uri = Uri.parse(_baseUrl + '/jobs/$id');
      final response = await _httpClient.delete(
        uri,
        headers: getHeaders(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          return true;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  // receipt Apis ...

  Future<List<Receipt>?> getReceipts([int page = 1]) async {
    late List<Receipt> result;
    try {
      // await refreshToken();
      final uri =
          Uri.parse(_baseUrl + '/financial/receipts/by-admin?page=$page');
      final response = await _httpClient.get(uri, headers: getHeaders());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        result =
            (jsonData['data'] as List).map((e) => Receipt.fromJson(e)).toList();
        return result;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.get(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonData = json.decode(response.body);
          result = (jsonData['data'] as List)
              .map((e) => Receipt.fromJson(e))
              .toList();
          return result;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<Receipt?> createReceipt(
    int userId,
    Salary salary,
    List<Deduction> deductions,
  ) async {
    try {
      final uri = Uri.parse(_baseUrl + '/financial/receipts');
      List<Map<String, dynamic>> deductionsList = deductions
          .map((d) => {
                "amount": d.amount,
                "type": d.type,
                "reason": d.reason,
              })
          .toList();
      Map<String, dynamic> body;
      body = {
        "userId": userId,
        "salary": {
          "workStartDate": salary.workStartDate!,
          "workEndDate": salary.workEndDate!,
          "bonus": salary.bonus,
          "allowance": salary.allowance,
        },
        "deductions": deductionsList
      };
      final response = await _httpClient.post(
        uri,
        headers: getHeaders(),
        body: json.encode(body),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final Receipt receipt = Receipt.fromJson(json['data']);
        return receipt;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final Receipt receipt = Receipt.fromJson(json['data']);
          return receipt;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
    return null;
  }

  Future<Receipt?> editReceipt(
    Receipt receipt,
    Salary salary,
    List<Deduction> deductions,
  ) async {
    try {
      final uri = Uri.parse(_baseUrl + '/financial/receipts/${receipt.id}');

      List<Map<String, dynamic>> deductionsList = deductions
          .map((d) => {
                "amount": d.amount,
                "type": d.type,
                "reason": d.reason,
              })
          .toList();
      Map<String, dynamic> body;
      body = {
        "userId": receipt.userId!,
        "salary": {
          "workStartDate": salary.workStartDate!,
          "workEndDate": salary.workEndDate!,
          "amount": salary.amount,
          "bonus": salary.bonus,
          "allowance": salary.allowance,
        },
        "deductions": deductionsList
      };

      final response = await _httpClient.put(
        uri,
        headers: getHeaders(),
        body: json.encode(body),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final Receipt receipt = Receipt.fromJson(json['data']);
        return receipt;
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          final Receipt receipt = Receipt.fromJson(json['data']);
          return receipt;
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
    return null;
  }

  Future<void> deleteReceipt(
    int receiptId,
  ) async {
    try {
      final uri = Uri.parse(_baseUrl + '/financial/receipts/$receiptId');
      final response = await _httpClient.delete(
        uri,
        headers: getHeaders(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('sucess deleting recipt ...');
      }
      if (response.statusCode == 401) {
        await refreshToken();
        final response = await _httpClient.post(uri, headers: getHeaders());
        if (response.statusCode == 200 || response.statusCode == 201) {
          print('sucess deleting recipt ...');
        }
      }
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }
}
