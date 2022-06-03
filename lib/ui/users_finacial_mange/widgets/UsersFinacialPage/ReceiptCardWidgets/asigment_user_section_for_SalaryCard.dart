import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

import '../../../../../models/receipt.dart';

class AsigmentUserSectionForSalaryCard extends StatelessWidget {
  final Receipt receipt;

  const AsigmentUserSectionForSalaryCard({Key? key, required this.receipt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Salary To Asignment :",
            textDirection: ui.TextDirection.rtl,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            Container(
              height: ScreenUtil().setSp(25),
              width: ScreenUtil().setSp(25),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Image(
                image: AssetImage('assets/images/useric.png'),
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(7),
            ),
            Text(
              receipt.user!.firstName + ' ' + receipt.user!.lastName,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
