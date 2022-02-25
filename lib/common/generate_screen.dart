import 'package:erb_mobo/ui/approvment_request_list/pages/approvment_requests.dart';
import 'package:erb_mobo/ui/auths/pages/affter_register_page.dart';
import 'package:erb_mobo/ui/auths/pages/auth_page.dart';
import 'package:erb_mobo/ui/auths/pages/forget_password_page.dart';
import 'package:erb_mobo/ui/home/pages/home_page.dart';
import 'package:erb_mobo/ui/my_profile/pages/my_profile.dart';
import 'package:erb_mobo/ui/splash/pages/splash_page.dart';
import 'package:flutter/material.dart';

import '../ui/users/pages/usersList.dart';

///
/// [GenerateScreen.onGenerate] function is responsible for returning the specific [Route] with the right data.
///
class GenerateScreen {
  static Route<dynamic> onGenerate(RouteSettings value) {
    String? name = value.name;
    // final Map args = value.arguments as Map<String, dynamic>;
    switch (name) {
      case NameScreen.splachScreen:
        {
          return MaterialPageRoute(builder: (context) => Splash());
        }
      case NameScreen.loginPage:
        {
          return MaterialPageRoute(builder: (context) => const AuthPage());
        }
      case NameScreen.afterRegisterPage:
        {
          return MaterialPageRoute(builder: (context) => AfterRegisterPage());
        }
      case NameScreen.forgetPasswordPage:
        {
          return MaterialPageRoute(builder: (context) => ForgetPasswordPage());
        }
      case NameScreen.homePage:
        {
          return MaterialPageRoute(builder: (context) => const HomePage());
        }
      case NameScreen.aprovmentRequestsPage:
        {
          return MaterialPageRoute(
              builder: (context) => const ApprovmentRequests());
        }
      case NameScreen.myProfilePage:
        {
          return MaterialPageRoute(builder: (context) => const MyProfilePage());
        }
      case NameScreen.usersListPage:
        {
          return MaterialPageRoute(builder: (context) => const UsersListPage());
        }
      // case NameScreen.receiptDetails:
      //   {
      //     return MaterialPageRoute(
      //         builder: (context) => const ReceiptDetails(
      //               receipt: args['s']
      //             ));
      //   }
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('ERROR'),
          ),
        );
      },
    );
  }
}

///
/// [NameScreen] class is responsible for declaring the routing names
///
class NameScreen {
  static const String splachScreen = '/spalchScreen';
  static const String loginPage = '/loginPage';
  static const String registerPage = '/registerPage';
  static const String afterRegisterPage = '/afterRegisterPage';
  static const String forgetPasswordPage = '/forgetPasswordPage';
  static const String homePage = 'homePage';
  static const String aprovmentRequestsPage = '/aprovmentRequestsPage';
  static const String myProfilePage = '/myProfilePage';
  static const String usersListPage = '/usersListPage';
  // static const String receiptDetails = '/receiptDetails';
}
