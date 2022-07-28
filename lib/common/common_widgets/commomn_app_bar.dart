import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/costant.dart';

AppBar commonAppBar({
  required String title,
  required BuildContext context,
  List<Widget>? actions,
  bool automaticallyImplyLeading: true,
}) {
  return AppBar(
    elevation: 0.0,
    automaticallyImplyLeading: automaticallyImplyLeading,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(gradient: ConstatValues.secGradientColor),
    ),
    // backgroundColor: Theme.of(context).primaryColor,
    iconTheme: IconThemeData(color: Colors.white),
    actions: actions ?? [],
  );
}
