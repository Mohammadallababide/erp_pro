import 'package:erb_mobo/common/common_widgets/app_snack_bar.dart';
import 'package:erb_mobo/common/generate_screen.dart';
import 'package:erb_mobo/common/theme_helper.dart';
import 'package:erb_mobo/core/validations/validtion.dart';
import 'package:erb_mobo/ui/auths/bloc/auths_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneNumController;
  final AuthsBloc authsBloc = AuthsBloc();
  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: authsBloc,
      listener: (context, state) {
        if (state is ErrorSingUp) {
          //todo show error alter
        } else if (state is SuccessSingUp) {
          //todo go to the next page....
          Navigator.pushNamed(
            context,
            NameScreen.afterRegisterPage,
          );
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: _firstNameController,
                decoration: ThemeHelper()
                    .textInputDecoration('First Name', 'Enter your first name'),
                validator: (val) => Validation.nonEmptyField(val!),
              ),
              decoration: ThemeHelper().inputBoxDecorationShaddow(),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            Container(
              child: TextFormField(
                controller: _lastNameController,
                decoration: ThemeHelper()
                    .textInputDecoration('Last Name', 'Enter your last name'),
                validator: (val) => Validation.nonEmptyField(val!),
              ),
              decoration: ThemeHelper().inputBoxDecorationShaddow(),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            Container(
              child: TextFormField(
                decoration: ThemeHelper()
                    .textInputDecoration("E-mail address", "Enter your email"),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (val) => Validation.emailValidation(val!),
              ),
              decoration: ThemeHelper().inputBoxDecorationShaddow(),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            Container(
              child: TextFormField(
                decoration: ThemeHelper().textInputDecoration(
                    "Mobile Number", "Enter your mobile number"),
                keyboardType: TextInputType.phone,
                controller: _phoneNumController,
                validator: (val) => Validation.phoneNumValidation(val!),
              ),
              decoration: ThemeHelper().inputBoxDecorationShaddow(),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            Container(
              child: TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: ThemeHelper()
                    .textInputDecoration("Password*", "Enter your password"),
                validator: (val) => Validation.passwordValidation(val!),
              ),
              decoration: ThemeHelper().inputBoxDecorationShaddow(),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            Container(
              child: TextFormField(
                obscureText: true,
                decoration: ThemeHelper().textInputDecoration(
                    "ConfirmPassword*", "Confirm a password"),
                validator: (val) => Validation.confirmPasswordValidation(
                    val!, _passwordController),
              ),
              decoration: ThemeHelper().inputBoxDecorationShaddow(),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(25),
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
                        "Register".toUpperCase(),
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(20),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () => submitForm(),
                  ),
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
      authsBloc.add(SingUp(
        firstName: _firstNameController.value.text,
        lastName: _lastNameController.value.text,
        password: _passwordController.value.text,
        email: _emailController.value.text,
        phoneNumber: _phoneNumController.value.text,
      ));
    } else {
       ScaffoldMessenger.of(context).showSnackBar( getAppSnackBar(message: 'info not completed yet!!',context:context));
    }
  }
}
