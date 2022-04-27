import 'dart:convert';
import 'dart:io';
import 'package:erb_mobo/data/local_data_source/shared_pref.dart';
import 'package:erb_mobo/models/salary.dart';
import 'package:erb_mobo/models/user.dart';
import 'package:http/http.dart' as http;

import '../../models/deduction.dart';
import '../../models/imageModel.dart';
import '../../models/invoice.dart';
import '../../models/job.dart';
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
  static const _baseUrl = "https://ite-ria.herokuapp.com/api/v1";

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

  Future<List<SalaryScale>> getSalaryScales([int page = 1]) async {
    late List<SalaryScale> salaryScales = [];
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
    return salaryScales;
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

  Future<List<Invoice>> getInvoices([int page = 1, int limit = 1]) async {
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
    return invoices;
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

  Future<Job?> createJob(
    String name,
    String description,
  ) async {
    try {
      final uri = Uri.parse(_baseUrl + '/jobs');
      Map<String, dynamic> body = <String, dynamic>{};
      body = {"name": name, "description": description};
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

  Future<List<Receipt>> getReceipts([int page = 1]) async {
    late List<Receipt> result = [];
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
    return result;
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
    int receiptId,
    Salary salary,
    List<Deduction> deductions,
  ) async {
    try {
      final uri = Uri.parse(_baseUrl + '/financial/receipts/$receiptId');

      List<Map<String, dynamic>> deductionsList = deductions
          .map((d) => {
                "amount": d.amount,
                "type": d.type,
                "reason": d.reason,
              })
          .toList();
      Map<String, dynamic> body;
      body = {
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
