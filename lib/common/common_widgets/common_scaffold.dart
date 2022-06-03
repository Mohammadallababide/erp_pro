import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'header_widget.dart';

class CommonScaffold extends StatelessWidget {
  final double headerHeight;
  final Widget childWidget;
  final Color? backgroundColor;
  const CommonScaffold({
    Key? key,
    required this.headerHeight,
    required this.childWidget,
    this.backgroundColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          this.backgroundColor == null ? Colors.white : this.backgroundColor,
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
                ScreenUtil().setWidth(0),
                ScreenUtil().setHeight(0),
                ScreenUtil().setWidth(0),
                ScreenUtil().setHeight(15),
              ),
              margin: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(15), 0, ScreenUtil().setWidth(15), 0),
              child: childWidget,
            )),
          ],
        ),
      ),
    );
  }
}
