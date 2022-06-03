import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget getFlashBar({
  required BuildContext context,
  required String title,
  required String message,
  bool isWarningMeg = false,
  bool isErrorgMeg = false,
}) {
  return Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    padding: EdgeInsets.all(ScreenUtil().setSp(20)),
    backgroundColor: isErrorgMeg
        ? Colors.red
        : isWarningMeg
            ? Colors.deepPurpleAccent
            : Colors.cyan,
    duration: Duration(seconds: 3),
    titleText: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: Colors.white,
      ),
    ),
    icon: Icon(
      isWarningMeg
          ? Icons.lightbulb_sharp
          : isErrorgMeg
              ? Icons.report_problem_rounded
              : Icons.check_circle_sharp,
      color: isWarningMeg
          ? Color.fromARGB(255, 251, 197, 34)
          : isErrorgMeg
              ? Colors.white
              : Color.fromARGB(255, 136, 255, 0),
      size: ScreenUtil().setSp(40),
    ),
    messageText: Text(
      message,
      style: TextStyle(
        fontSize: 15.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  )..show(context);
}
