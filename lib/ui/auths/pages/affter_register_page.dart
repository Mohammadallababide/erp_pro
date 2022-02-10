import 'package:erb_mobo/common/common_widgets/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AfterRegisterPage extends StatelessWidget {
  AfterRegisterPage({Key? key}) : super(key: key);
  final double _headerHeight = ScreenUtil().setHeight(250);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      headerHeight: _headerHeight,
      childWidget: Column(children: [
        Text(
          'Thank you for register                           We send your register request to the admin !',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(45),
              color: Colors.indigoAccent,
              fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
