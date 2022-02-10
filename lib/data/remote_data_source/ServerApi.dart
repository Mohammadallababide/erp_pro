import 'dart:convert';
import 'dart:io';
import 'package:erb_mobo/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http_retry/http_retry.dart';

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
      //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJyaWFAcmlhLmNvbSIsImlhdCI6MTY0MjI1NDc2NCwiZXhwIjoxNjQyMjU2NTY0fQ.B0tHLaZZ0Jp1YQlwXDtMFTad04wdkfAYUXZFVxGGBYg',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  String getLocalToken() {
    return accessToken ?? '';
  }

  //Auth

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
      Map<String, String> body = Map<String, String>();
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
      Map<String, String> body = Map<String, String>();
      body = {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
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
      final uri = Uri.parse(_baseUrl + '/user/for-admin');
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

  Future<bool> approveSignupUser(int userId) async {
    try {
      final uri = Uri.parse(_baseUrl + '/auth-for-admin/approve-user/$userId');
      final response = await _httpClient.post(uri, headers: getHeaders());
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
}
