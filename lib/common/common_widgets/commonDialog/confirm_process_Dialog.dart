import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showConfeirmProcessAlert(
    {required BuildContext context,
    required Function submitProcessFun,
    required Function cancelProcessFun,
    required String prcessedText,
    required Icon icon}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(children: [icon, const Text('  Alert Dialog. ')]),
        content: Text(prcessedText),
        actions: <Widget>[
          TextButton(
              child: Text(
                "YES",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(15),
                ),
              ),
              onPressed: () => submitProcessFun()),
          TextButton(
            child: Text(
              "CANCEL",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(15),
              ),
            ),
            onPressed: () => cancelProcessFun(),
          ),
        ],
      );
    },
  );
}
