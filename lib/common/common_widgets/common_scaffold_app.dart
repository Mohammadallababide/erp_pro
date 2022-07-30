import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../../core/utils/costant.dart';
import 'app_drawer.dart';
import 'common_bottom_navigation_bar.dart';

class CommonScaffoldApp extends StatefulWidget {
  final String title;
  final bool? isDrawer;
  final List<Widget>? actions;
  final bool? automaticallyImplyLeading;
  final PreferredSize? bottom;
  final bool? isBakedNav;
  final Widget? flb;
  final Widget child;
  const CommonScaffoldApp({
    Key? key,
    required this.title,
    this.actions,
    required this.child,
    this.automaticallyImplyLeading = true,
    this.isBakedNav = false,
    this.bottom,
    this.flb,
    this.isDrawer = false,
  }) : super(key: key);

  @override
  State<CommonScaffoldApp> createState() => _CommonScaffoldAppState();
}

const duration = Duration(milliseconds: 300);

class _CommonScaffoldAppState extends State<CommonScaffoldApp> {
  late bool isFabVasibale = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void listToisFabVasibaleAction(bool value) {
    setState(() {
      isFabVasibale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!widget.isBakedNav!) {
          SystemNavigator.pop();
        }
        return false;
      },
      child: Scaffold(
        drawer: widget.isDrawer != null ? AppDrawer() : null,
        bottomNavigationBar: CommonBottomNavigationBar(),
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: widget.automaticallyImplyLeading!,
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: ConstatValues.secGradientColor),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          actions:
              (!isFabVasibale && widget.actions != null) ? widget.actions : [],
          bottom: widget.bottom,
        ),
        floatingActionButton: AnimatedSlide(
          duration: duration,
          offset: isFabVasibale ? Offset.zero : Offset(0, 2),
          child: AnimatedOpacity(
            duration: duration,
            opacity: isFabVasibale ? 1 : 0,
            child: widget.flb,
          ),
        ),
        body: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.forward) {
                setState(() {
                  isFabVasibale = true;
                });
              } else if (notification.direction == ScrollDirection.reverse) {
                setState(() {
                  isFabVasibale = false;
                });
              }
              return true;
            },
            child: widget.child),
      ),
    );
  }
}
