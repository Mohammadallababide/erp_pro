import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'header_widget.dart';

class CommonScaffold extends StatelessWidget {
  final double headerHeight;
  final Widget childWidget;
  const CommonScaffold({
    Key? key,
    required this.headerHeight,
    required this.childWidget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: headerHeight,
              child: HeaderWidget(headerHeight, true, Icons.person),
            ),
            SafeArea(
                child: Container(
              padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(15),
                ScreenUtil().setHeight(15),
                ScreenUtil().setWidth(15),
                ScreenUtil().setHeight(15),
              ),
              margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), 0, ScreenUtil().setWidth(15), 0),
              child: childWidget,
            )),
          ],
        ),
      ),
    );
  }
}
