import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SnackBar getAppSnackBar(
    {required String message, bool isSuccessMessage = false ,required BuildContext context}) {
  return SnackBar(
    content: Padding(
      padding:  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10),),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            message,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(18),
            ),
          ),
          Icon(isSuccessMessage ? Icons.check_box_outlined : Icons.error,
              color: !isSuccessMessage ? Colors.red : Colors.green,size: ScreenUtil().setSp(30),)
        ],
      ),
    ),
    backgroundColor: (Theme.of(context).primaryColor.withAlpha(70)),

    // action: SnackBarAction(
    //   label: 'dismiss',
    //   onPressed: () {
    //   },
    // ),
  );
}
