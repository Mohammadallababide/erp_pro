import 'package:flutter/material.dart';

AppBar commonAppBar({required String title, required BuildContext context }) {
  return AppBar(
    elevation: 0.0,
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Theme.of(context).primaryColor,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );
}
