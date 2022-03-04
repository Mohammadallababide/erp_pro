import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showConfeirmProcessAlert({
  required BuildContext context,
  required Function submitProcessFun,
  required Function cancelProcessFun,
  required String prcessedText,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(children: [
          Image.network(
            'https://flutter-examples.com/wp-content/uploads/2019/12/android_icon.png',
            width: ScreenUtil().setSp(50),
            height: ScreenUtil().setSp(50),
            fit: BoxFit.contain,
          ),
          const Text('  Alert Dialog Title. ')
        ]),
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
