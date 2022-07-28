import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/costant.dart';

class CommonBottomNavigationBar extends StatelessWidget {
  const CommonBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(10),
        left: ScreenUtil().setWidth(5),
        right: ScreenUtil().setWidth(5),
      ),
      child: ConvexAppBar(
        gradient: ConstatValues.secGradientColor,
        // backgroundColor: Colors.indigo,
        activeColor: Colors.white,
        color: Color.fromARGB(255, 8, 65, 60).withOpacity(0.6),
        top: -15,

        curveSize: 80,
        style: TabStyle.fixedCircle,
        height: ScreenUtil().setHeight(50),
        cornerRadius: ScreenUtil().radius(15),
        curve: Curves.decelerate,
        // elevation: 0,
        // activeColor: Colors.white,
        items: [
          TabItem(
            icon: Icons.receipt_outlined,
            // title: 'reciepts',
          ),
          TabItem(
            icon: Icons.description_rounded,
            // title: 'invoices',
          ),
          TabItem(
            icon: Icons.dashboard_rounded,
            // title: 'dashboard',
          ),
          TabItem(
            icon: Icons.notifications,
            // title: 'notificati',
          ),
          TabItem(
            icon: Icons.account_circle_rounded,
            // title: 'my profile',
          ),
        ],
        initialActiveIndex: 1,
        onTap: (int i) => print('click index=$i'),
      ),
    );
  }
}
