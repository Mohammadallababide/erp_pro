import 'package:erb_mobo/common/common_widgets/app_snack_bar.dart';
import 'package:erb_mobo/common/generate_screen.dart';
import 'package:erb_mobo/common/theme_helper.dart';
import 'package:erb_mobo/core/validations/validtion.dart';
import 'package:erb_mobo/ui/auths/bloc/auths_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final AuthsBloc authsBloc = AuthsBloc();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: authsBloc,
      listener: (context, state) {
        if (state is ErrorSingIn) {
          ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
              message: 'Faild! some thing wrong.', context: context));
        } else if (state is SuccessSingIn) {
          Navigator.pushReplacementNamed(
            context,
            NameScreen.homePage,
          );
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (val) => Validation.emailValidation(val!),
                decoration: ThemeHelper()
                    .textInputDecoration('email', 'Enter your email address'),
              ),
              decoration: ThemeHelper().inputBoxDecorationShaddow(),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Container(
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (val) => Validation.passwordValidation(val!),
                decoration: ThemeHelper()
                    .textInputDecoration('Password', 'Enter your password'),
              ),
              decoration: ThemeHelper().inputBoxDecorationShaddow(),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(10), 0, ScreenUtil().setWidth(5), 0),
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, NameScreen.forgetPasswordPage);
                },
                child: const Text(
                  "Forgot your password?",
                  style: TextStyle(
                    color: Colors.lightBlue,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(35),
            ),
            BlocBuilder(
              bloc: authsBloc,
              builder: (context, state) {
                if (state is AuthProcessing) {
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                          strokeWidth: ScreenUtil().setWidth(3),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(15),
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  decoration: ThemeHelper().buttonBoxDecoration(context),
                  child: ElevatedButton(
                      style: ThemeHelper().buttonStyle(),
                      child: Center(
                        child: Text(
                          'Sign In'.toUpperCase(),
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(20),
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      onPressed: () => submitForm()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void submitForm() {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      authsBloc.add(SingIn(
        password: _passwordController.value.text,
        email: _emailController.value.text,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
          message: 'info not completed yet!!', context: context));
    }
  }
}
