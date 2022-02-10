import 'package:erb_mobo/common/generate_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3.0,
      backgroundColor: Colors.white70,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(context),
          _createDrawerItem(
            icon: Icons.account_circle,
            text: 'My profile',
             onTap: () => Navigator.pushReplacementNamed(
              context,
              NameScreen.myProfilePage,
            ),
          ),
          _createDrawerItem(
            icon: Icons.settings,
            text: 'Setting',
          ),
          _createDrawerItem(
            icon: Icons.event,
            text: 'Events',
          ),
          const Divider(
            thickness: 2,
          ),
          _createDrawerItem(
            icon: Icons.list_alt,
            text: 'Requests Approvment',
            onTap: () => Navigator.pushReplacementNamed(
              context,
              NameScreen.aprovmentRequestsPage,
            ),
          ),
          _createDrawerItem(
            icon: Icons.note,
            text: 'Notes',
          ),
           const Divider(
            thickness: 2,
          ),
          ListTile(
            title: const Text('v.0.2'),
            onTap: () {},
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
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text!),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _createHeader(context) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          image: const DecorationImage(
              fit: BoxFit.fill, image: AssetImage('assets/images/brick.png'))),
      child: null,
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