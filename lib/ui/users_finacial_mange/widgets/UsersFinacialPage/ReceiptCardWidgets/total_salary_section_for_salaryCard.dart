import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

import '../../../../../models/receipt.dart';

class TotalSalarySectionForSalaryCard extends StatelessWidget {
  final Receipt receipt;
  const TotalSalarySectionForSalaryCard({Key? key, required this.receipt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildTotalSalarySectionForSalaryCard();
  }

  int calculateTotalSalarValue(Receipt receipt) {
    int totalDedection = 0;
    for (int i = 0; i < receipt.deductions.length; i++) {
      totalDedection = totalDedection + receipt.deductions[i].amount;
    }
    return (receipt.salary.amount +
            receipt.salary.bonus +
            (receipt.salary.allowance ?? 0)) -
        totalDedection;
  }

  Column buildTotalSalarySectionForSalaryCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Total Salary :",
            textDirection: ui.TextDirection.rtl,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(5),
          ),
          child: Row(
            children: [
              Text(
                calculateTotalSalarValue(receipt).toString(),
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(2),
              ),
              Icon(
                Icons.attach_money_outlined,
                size: ScreenUtil().setSp(20),
              )
            ],
          ),
        ),
      ],
    );
  }
}
