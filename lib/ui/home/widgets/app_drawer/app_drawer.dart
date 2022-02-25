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
          _createDrawerItem(
            icon: Icons.notifications,
            text: 'notifications',
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
              style: TextStyle(color: Colors.white),
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
        decoration: BoxDecoration(
          color: Colors.black12
        ),
        currentAccountPictureSize: Size.square(ScreenUtil().setSp(80)),
        accountName: Text(
          "Michel Clerk",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(18),
          ),
        ),
        accountEmail: Text("Michel@gmail.com",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: ScreenUtil().setSp(14),
            )),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            "M",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(40),
            ),
          ),
        ),
      ),
    );
  }
}




    //  _createDrawerItem(
    //         icon: Icons.account_circle,
    //         text: 'My profile',
    //       ),
    //       _createDrawerItem(
    //         icon: Icons.settings,
    //         text: 'Setting',
    //       ),
    //       _createDrawerItem(
    //         icon: Icons.event,
    //         text: 'Events',
    //       ),
    //       const Divider(
    //         thickness: 2,
    //       ),
    //        _createDrawerItem(
    //         icon: Icons.note,
    //         text: 'Notes',
    //       ),
    //       _createDrawerItem(icon: Icons.collections_bookmark, text: 'Steps'),
    //       _createDrawerItem(icon: Icons.face, text: 'Authors'),
    //       _createDrawerItem(
    //           icon: Icons.account_box, text: 'Flutter Documentation'),
    //       _createDrawerItem(icon: Icons.stars, text: 'Useful Links'),
    //       const Divider(
    //         thickness: 2,
    //       ),
    //       _createDrawerItem(icon: Icons.bug_report, text: 'Report an issue'),