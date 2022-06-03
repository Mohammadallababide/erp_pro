import 'package:erb_mobo/core/utils/app_snack_bar.dart';
import 'package:erb_mobo/common/generate_screen.dart';
import 'package:erb_mobo/common/theme_helper.dart';
import 'package:erb_mobo/core/validations/validtion.dart';
import 'package:erb_mobo/ui/auths/bloc/auths_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
  late bool isVisableActionValue = true;

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
              height: ScreenUtil().setHeight(30),
            ),
            Container(
              child: TextFormField(
                controller: _passwordController,
                obscureText: isVisableActionValue,
                validator: (val) => Validation.passwordValidation(val!),
                decoration: passwordInputDecoration(),
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
              height: ScreenUtil().setHeight(85),
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
                  decoration:
                      ThemeHelper().buttonBoxDecoration(context: context),
                  child: ElevatedButton(
                      style: ThemeHelper().buttonStyle(),
                      child: Center(
                        child: Text(
                          'Log In'.toUpperCase(),
                          style: GoogleFonts.belleza(
                            fontStyle: FontStyle.normal,
                            textStyle: TextStyle(
                              fontSize: ScreenUtil().setSp(26),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
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

  InputDecoration passwordInputDecoration() {
    return InputDecoration(
      suffixIcon: IconButton(
        onPressed: () => setState(() {
          isVisableActionValue = !isVisableActionValue;
        }),
        icon: Icon(
          !isVisableActionValue ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
      ),
      labelText: 'password',
      labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: ScreenUtil().setSp(16),
          fontWeight: FontWeight.bold),
      hintText: 'Enter your password',
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.0),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
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
