import 'package:erb_mobo/ui/approvment_request_list/pages/approvment_requests.dart';
import 'package:erb_mobo/ui/auths/pages/affter_register_page.dart';
import 'package:erb_mobo/ui/auths/pages/auth_page.dart';
import 'package:erb_mobo/ui/auths/pages/forget_password_page.dart';
import 'package:erb_mobo/ui/home/pages/home_page.dart';
import 'package:erb_mobo/ui/my_profile/pages/my_profile.dart';
import 'package:erb_mobo/ui/splash/pages/splash_page.dart';
import 'package:flutter/material.dart';

import '../ui/company_jobs/pages/company_jobs_center_page.dart';
import '../ui/company_jobs/pages/job_details_page.dart';
import '../ui/users List/pages/users_list_page.dart';
import '../ui/users_finacial_mange/pages/create_or_edit_receipt_page.dart';
import '../ui/users_finacial_mange/pages/users_finacial_page.dart';
import 'common_widgets/ReceiptDetailsWidgets/receipt_details.dart';

///
/// [GenerateScreen.onGenerate] function is responsible for returning the specific [Route] with the right data.
///
class GenerateScreen {
  static Route<dynamic> onGenerate(RouteSettings value) {
    String? name = value.name;
      // final arg = value.arguments as Map;
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
      case NameScreen.usersFinacialPage:
        {
          return MaterialPageRoute(
              builder: (context) => const UsersFinacialPage());
        }
      case NameScreen.createOrEditUserReceiptPage:
        {
          return MaterialPageRoute(
              builder: (context) => const CreateOrEditUserReceiptPage());
        }
      case NameScreen.jobsCenterPage:
        {
          return MaterialPageRoute(
              builder: (context) => const CompanyJobsCenterPage());
        }
      // case NameScreen.jobDetails:
      //   {
      //     return MaterialPageRoute(
      //         builder: (context) => JobDetailsPage(
      //               jobDetails: arg['jobDetails'],
      //             ));
      //   }

      // case NameScreen.receiptDetails:
      //   {

      //     return MaterialPageRoute(
      //         builder: (context) => ReceiptDetails(
      //               isMyReceipt: arg['isMyReceipt'],
      //               receipt: arg['receipt'],
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
  static const String usersFinacialPage = '/usersFinacialPage';
  static const String createOrEditUserReceiptPage = '/createUserReceiptPage';
  static const String jobsCenterPage = '/jobsCenterPage';
  static const String jobDetails = '/jobDetials';
  // static const String receiptDetails = '/receiptDetails';
}
