import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Theme.of(context).primaryColor,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    actions: actions ?? [],
  );
}
