import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

import '../../../../../core/utils/core_util_function.dart';
import '../../../../../models/receipt.dart';

class NumberAndDateRangeSectionForSalaryCard extends StatelessWidget {
  final Receipt receipt;
  final int index;
  const NumberAndDateRangeSectionForSalaryCard({
    Key? key,
    required this.receipt,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: ScreenUtil().setHeight(15),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                ScreenUtil().setSp(150),
              ),
              child: Center(
                child: Text(
                  index.toString(),
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Text(
              "From ${CorerUtilFunction.getFormalDate(
                receipt.salary.workStartDate!,
              )} To ${CorerUtilFunction.getFormalDate(
                receipt.salary.workEndDate!,
              )}",
              textDirection: ui.TextDirection.ltr,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(5),
            ),
            Icon(
              Icons.date_range,
              size: ScreenUtil().setSp(15),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ],
    );
  }
}
