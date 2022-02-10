import 'package:flutter/material.dart';

class Validation {
  static String? emailValidation(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(email);
    if (!emailValid) {
      return "Enter a valid email address";
    }
    return null;
  }

  static String? passwordValidation(String password) {
    if (password.length <= 6) {
      return "Password must be atleast 6 characters long";
    }
    return null;
  }

  static String? confirmPasswordValidation(
      String confirmPassword, TextEditingController confirmPass) {
      if (confirmPassword.isEmpty) {
      return "this faild can'\t be empty";
    } else if (confirmPassword.length < 6) {
      return "Password must be atleast 6 characters long";
    } else if (confirmPassword != confirmPass.text) {
      return "Password must be same as above";
    } else {
      return null;
    }
  }

  static String? phoneNumValidation(String phoneNum) {
     if(phoneNum.isEmpty){
      return "This Field can not be empty !";
    }
   else if (!(phoneNum.isEmpty) && !RegExp(r"^(\d+)*$").hasMatch(phoneNum)) {
      return "Enter a valid phone number";
    }
    return null;
  }


  static String? nonEmptyField(String value){
    if(value.isEmpty){
      return "This Field can not be empty !";
    }
    return null;
  }
}
