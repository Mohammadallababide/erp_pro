import 'package:erb_mobo/models/salary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SalaryInfoDetails extends StatelessWidget {
  final Salary salaryDetails;
  const SalaryInfoDetails({Key? key, required this.salaryDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: ScreenUtil().setHeight(25),
        ),
        Column(children: [
          buildSalaryDetails(salaryDetails.amount.toString(), 'Salary amount :', context),
          buildSalaryDetails(salaryDetails.bonus.toString(), 'bonus on salary :', context),
          buildSalaryDetails(salaryDetails.allowance.toString(), 'allowance amount :', context),
        ]),
      ],
    );
  }



Widget buildSalaryDetails(
        String getValue, String title, BuildContext context) =>
    Padding(
      padding: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.w700,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
            width:
                MediaQuery.of(context).size.width - ScreenUtil().setWidth(30),
            height: ScreenUtil().setHeight(38),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1.5,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    getValue,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      height: ScreenUtil().setHeight(1.5),
                    ),
                  ),
                ),
                Icon(
                  Icons.attach_money_outlined,
                  color: Theme.of(context).primaryColor,
                  size: ScreenUtil().setSp(27),
                )
              ],
            ),
          )
        ],
      ),
    );
}