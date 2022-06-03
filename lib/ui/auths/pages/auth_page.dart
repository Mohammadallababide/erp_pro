import 'package:erb_mobo/common/common_widgets/common_scaffold.dart';
import 'package:erb_mobo/ui/auths/widgets/login_form.dart';
import 'package:erb_mobo/ui/auths/widgets/register_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final double _headerHeight = ScreenUtil().setHeight(200);

  bool isHaveAccount = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: CommonScaffold(
          
          headerHeight: _headerHeight,
          childWidget: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(5),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isHaveAccount
                        ? 'LogIn to the system'
                        : 'Create new account!',
                    style: GoogleFonts.yanoneKaffeesatz(
                      fontStyle: FontStyle.italic,
                      textStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(40),
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: isHaveAccount
                    ? ScreenUtil().setHeight(50)
                    : ScreenUtil().setHeight(25),
              ),
              isHaveAccount
                  ? const Align(
                      alignment: Alignment.center,
                      child: LoginForm(),
                    )
                  : const RegisterForm(),
              SizedBox(
                height: ScreenUtil().setHeight(25),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: isHaveAccount
                          ? "Don\'t have an account? "
                          : "I alrady have account? ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: isHaveAccount ? 'signup' : 'login',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            isHaveAccount = !isHaveAccount;
                          });
                        },
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
