import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/costant.dart';

class CommonAddFLB extends StatelessWidget {
  final Object? heroTag;
  final IconData icon;
  final Function()? func;
  const CommonAddFLB({Key? key, this.heroTag, this.func, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: ConstatValues.secGradientColor,
      ),
      child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          heroTag: null,
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
              size: ScreenUtil().setSp(30),
            ),
          ),
          onPressed: func),
    );
  }
}
