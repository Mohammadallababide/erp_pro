import 'package:erb_mobo/common/generate_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/local_data_source/shared_pref.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      backgroundColor: Theme.of(context).primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(context),
          // _createDrawerItem(
          //   icon: Icons.notifications,
          //   text: 'notifications',
          // ),
          // const Divider(
          //   thickness: 2,
          //   color: Colors.white,
          // ),
          _createDrawerItem(
            icon: Icons.attach_money,
            text: 'users financial mange',
            onTap: () => Navigator.pushReplacementNamed(
              context,
              NameScreen.usersFinacialPage,
            ),
          ),
          const Divider(
            thickness: 2,
            color: Colors.white,
          ),
          _createDrawerItem(
            icon: Icons.verified_user_sharp,
            text: 'approvment requests',
            onTap: () => Navigator.pushReplacementNamed(
              context,
              NameScreen.aprovmentRequestsPage,
            ),
          ),
          const Divider(
            thickness: 2,
            color: Colors.white,
          ),
          _createDrawerItem(
            icon: Icons.supervised_user_circle_sharp,
            text: 'approvment users',
            onTap: () => Navigator.pushReplacementNamed(
                context, NameScreen.usersListPage),
          ),
          const Divider(
            thickness: 2,
            color: Colors.white,
          ),
          _createDrawerItem(
              icon: Icons.logout_outlined,
              text: 'logout',
              onTap: () {
                SharedPref.logOut();
                Navigator.pushReplacementNamed(context, NameScreen.loginPage);
              }),
          const Divider(
            thickness: 2,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              text!,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _createHeader(context) {
    return InkWell(
      onTap: () => Navigator.pushReplacementNamed(
        context,
        NameScreen.myProfilePage,
      ),
      child: UserAccountsDrawerHeader(
        decoration: const BoxDecoration(color: Colors.black12),
        currentAccountPictureSize: Size.square(ScreenUtil().setSp(70)),
        accountName: Text(
          "ria ria",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(17),
          ),
        ),
        accountEmail: Text("ria@ria.com",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: ScreenUtil().setSp(14),
            )),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            "R",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(40),
            ),
          ),
        ),
      ),
    );
  }
}
