import 'dart:convert';
import 'dart:io';
import 'package:erb_mobo/data/local_data_source/shared_pref.dart';
import 'package:erb_mobo/models/salary.dart';
import 'package:erb_mobo/models/user.dart';
import 'package:http/http.dart' as http;

import '../../models/deduction.dart';
import '../../models/receipt.dart';

class ServerApi {
  ServerApi._() {
    getLocalToken();
  }

  late String language;
  static String? accessToken;
  static final ServerApi apiClient = ServerApi._();
  static final http.Client _httpClient = http.Client();
  static const _baseUrl = "https://ite-ria.herokuapp.com/api/v1";

  Map<String, String> getHeaders() {
    print('Bearer ${getLocalToken().toString()}');
    return {
      'Authorization': 'Bearer ${getLocalToken()}',
      // 'Authorization':
      //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJyaWFAcmlhLmNvbSIsImlhdCI6MTY0NTIxMjY2MSwiZXhwIjoxNjQ1MjE0NDYxfQ.bomQH19tHC8Wd5gf9QOxHgWe7GBTKwUWOOFws-alXGY',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  String? getLocalToken() {
    return SharedPref.getToken();
  }

  //Auth

  Future<String?> uploadImage(filepath) async {
    try {
      var postUri = Uri.parse(_baseUrl + '/app-files');
      var request = http.MultipartRequest('POST', postUri);
      request.files.add(http.MultipartFile('image',
          File(filepath).readAsBytes().asStream(), File(filepath).lengthSync(),
          filename: filepath.split("/").last));
      var res = await request.send();
      if (res.statusCode == 200 || res.statusCode == 201) {
        print('sucess uploading user image');
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

  Future<void> refreshToken() async {
    try {
      final uri = Uri.parse(_baseUrl + '/auth/refresh?token=$accessToken');
      final response = await _httpClient.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        accessToken = json['data']['refreshToken'];
        SharedPref.setToken(accessToken!);
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
          accessToken = json['data']['accessToken'];
          SharedPref.setToken(accessToken!);
        }
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

  Future<List<User>> getUsersRequestsSignupApprovment() async {
    late List<User> result = [];
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
    return result;
  }

  Future<List<User>> getUsersApprovment() async {
    late List<User> result = [];
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
    return result;
  }

  Future<User?> approveSignupUser(int userId) async {
    try {
      final uri = Uri.parse(_baseUrl + '/auth-for-admin/approve-user/$userId');
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

  // receipt Apis ...

  Future<List<Receipt>> getReceipts([int page = 1]) async {
    late List<Receipt> result = [];
    try {
      // await refreshToken();
      final uri = Uri.parse(_baseUrl + '/financial/receipts');
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
    return result;
  }

  Future<Receipt?> createReceipt(
    int userId,
    Salary salary,
    List<Deduction> deductions,
  ) async {
    try {
      final uri = Uri.parse(_baseUrl + '/financial/receipts');

      Map<String, dynamic> body = <String, dynamic>{};
      body = {
        'userId': userId,
        'salary': salary.toJson(),
        'deductions': deductions.map((e) => e.toJson()).toList(),
      };
      final bodReq = jsonEncode(body);

      final response = await _httpClient.post(
        uri,
        headers: getHeaders(),
        body: bodReq,
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
  }

  Future<Receipt?> deleteReceipt(
    int receiptId,
  ) async {
    try {
      final uri = Uri.parse(_baseUrl + '/financial/receipts/$receiptId');
      final response = await _httpClient.delete(
        uri,
        headers: getHeaders(),
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
  }
}
