
import 'package:erb_mobo/common/common_widgets/common_scaffold.dart';
import 'package:erb_mobo/ui/auths/widgets/login_form.dart';
import 'package:erb_mobo/ui/auths/widgets/register_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return CommonScaffold(
      headerHeight: _headerHeight,
      childWidget: Column(
        children: [
          Text(
            isHaveAccount
                ? 'Welcome                          Again!'
                : 'Create                          new account!',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(45),
                color: Colors.indigoAccent,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          isHaveAccount ? const LoginForm() : const RegisterForm(),
          SizedBox(
            height: ScreenUtil().setHeight(25),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: isHaveAccount
                        ? "Don\'t have an account? "
                        : "I alrady have account? "),
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
                      color:Colors.blueAccent,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
