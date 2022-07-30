import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoSectionRow extends StatelessWidget {
  final String title;
  final dynamic value;
  final bool? isBottomPadding;
  InfoSectionRow({
    Key? key,
    required this.title,
    required this.value,
    this.isBottomPadding,
  }) : super(key: key);
  late bool isBottomPaddingValue = isBottomPadding ?? true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: isBottomPaddingValue ? ScreenUtil().setHeight(20) : 0,
        left: ScreenUtil().setWidth(5),
        right: ScreenUtil().setWidth(5),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.teal,
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(7),
          ),
          Text(
            value.toLowerCase(),
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
