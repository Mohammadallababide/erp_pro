import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CusBottomNavigationBar extends StatefulWidget {
  const CusBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _CusBottomNavigationBarState createState() => _CusBottomNavigationBarState();
}

class _CusBottomNavigationBarState extends State<CusBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(10),
          vertical: ScreenUtil().setHeight(5)),
      child: SizedBox(
        height: ScreenUtil().setHeight(60),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(
                ScreenUtil().radius(17),
              ),
              topLeft: Radius.circular(
                ScreenUtil().radius(8),
              ),
              topRight: Radius.circular(
                ScreenUtil().radius(8),
              ),
              bottomRight: Radius.circular(
                ScreenUtil().radius(17),
              )),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            enableFeedback: false,
            backgroundColor: Colors.black87,
            elevation: 2,
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            selectedFontSize: ScreenUtil().setSp(13),
            unselectedFontSize: ScreenUtil().setSp(11),
            unselectedItemColor: Colors.white38,
            selectedItemColor: Colors.white,
            selectedIconTheme: IconThemeData(
              color: Colors.white,
              size: ScreenUtil().setSp(22),
            ),
            unselectedIconTheme: IconThemeData(
              color: Colors.white38,
              size: ScreenUtil().setSp(20),
            ),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Personal Info',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.attach_money_outlined),
                label: 'Salary Info',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
