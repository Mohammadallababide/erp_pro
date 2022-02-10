
import 'package:erb_mobo/common/common_widgets/common_scaffold.dart';
import 'package:erb_mobo/ui/auths/widgets/forget_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({Key? key}) : super(key: key);
  final double _headerHeight = ScreenUtil().setHeight(230);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      headerHeight: _headerHeight,
      childWidget: Column(children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(15), 0, ScreenUtil().setWidth(15), 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Password?',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(35),
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              const Text(
                'Enter your email address',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              const Text(
                'We will email you a verification code to check your authenticity.',
                style: TextStyle(
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(35)),
        const ForgetPasswordForm(),
      ]),
    );
  }
}
