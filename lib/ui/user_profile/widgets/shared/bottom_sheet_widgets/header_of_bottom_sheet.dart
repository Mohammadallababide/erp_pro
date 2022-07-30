import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderOfBottomSheet extends StatelessWidget {
  final String title;
  final IconData icon;
  const HeaderOfBottomSheet({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.teal,
          size: ScreenUtil().setSp(30),
        ),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(17),
          ),
        ),
        Divider(
          thickness: 2, // thickness of the line
          indent: ScreenUtil().setSp(35),
          endIndent: ScreenUtil().setSp(35),
          color: Colors.teal,
          height: ScreenUtil().setHeight(25),
        ),
      ],
    );
  }
}
