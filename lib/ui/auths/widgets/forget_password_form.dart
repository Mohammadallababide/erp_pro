import 'package:erb_mobo/common/theme_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({ Key? key }) : super(key: key);

  @override
  _ForgetPasswordFormState createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final Key _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return   Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                child: TextFormField(
                  decoration: ThemeHelper()
                      .textInputDecoration("Email", "Enter your email"),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Email can't be empty";
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                        .hasMatch(val)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),
                decoration: ThemeHelper().inputBoxDecorationShaddow(),
              ),
              SizedBox(height: ScreenUtil().setHeight(35)),
              Container(
                decoration: ThemeHelper().buttonBoxDecoration(context),
                child: ElevatedButton(
                  style: ThemeHelper().buttonStyle(),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(40), 0,
                        ScreenUtil().setWidth(40), 0),
                    child: Text(
                      "Send".toUpperCase(),
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () {
                    // if(_formKey.currentState!.validate()) {
                    //   Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ForgotPasswordVerificationPage()),
                    //   );
                    // }
                  },
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(25)),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: "Remember your password? "),
                    TextSpan(
                      text: 'Login',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        },
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.lightBlue),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
  }
}