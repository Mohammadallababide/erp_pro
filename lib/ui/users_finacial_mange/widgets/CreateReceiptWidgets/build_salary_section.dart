import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/theme_helper.dart';
import 'build_salary_asignment_user_section.dart';
import 'build_salary_date_faild.dart';

Column buildSalarySection(BuildContext context) {
  return Column(
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Salary info Section',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(15),
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      SizedBox(
        height: ScreenUtil().setHeight(20),
      ),
      Container(
        child: TextFormField(
          // controller: _emailController,
          keyboardType: TextInputType.number,
          // validator: (val) => Validation.emailValidation(val!),
          decoration: ThemeHelper()
              .textInputDecoration('salary amount', 'salary amount'),
        ),
        decoration: ThemeHelper().inputBoxDecorationShaddow(),
      ),
      SizedBox(
        height: ScreenUtil().setHeight(15),
      ),
      Container(
        child: TextFormField(
          // controller: _emailController,
          keyboardType: TextInputType.number,
          // validator: (val) => Validation.emailValidation(val!),
          decoration: ThemeHelper()
              .textInputDecoration('bonus on salary', 'bonus on salary'),
        ),
        decoration: ThemeHelper().inputBoxDecorationShaddow(),
      ),
      SizedBox(
        height: ScreenUtil().setHeight(15),
      ),
      Container(
        child: TextFormField(
          // controller: _emailController,
          keyboardType: TextInputType.number,
          // validator: (val) => Validation.emailValidation(val!),
          decoration: ThemeHelper()
              .textInputDecoration('allowance amount', 'allowance amount'),
        ),
        decoration: ThemeHelper().inputBoxDecorationShaddow(),
      ),
      SizedBox(
        height: ScreenUtil().setHeight(25),
      ),
      buildSalaryAsignmentUserSection(context),
      SizedBox(
        height: ScreenUtil().setHeight(25),
      ),
      SlarayDateRangeFaild(
          startSalaryDate: '1/1/2000',
          endSalaryDate: '1/2/2000',
          title: 'Salary Range Date'),
    ],
  );
}
