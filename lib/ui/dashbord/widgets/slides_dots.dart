import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlideDots extends StatelessWidget {
  final bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(5),
      ),
      height: isActive ? ScreenUtil().setSp(10) : ScreenUtil().setSp(7),
      width: isActive ? ScreenUtil().setSp(15) : ScreenUtil().setSp(10),
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().radius(15))),
      ),
    );
  }
}
