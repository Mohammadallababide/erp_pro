import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/common_widgets/custom_dividor_line.dart';
import '../../../../../models/user.dart';
import '../../../../../common/common_widgets/CardTilesWidgets/user_card_tile.dart';

class DepartmentUsersInfoTab extends StatefulWidget {
  final List<User> users;
  final List<User> superUsers;
  const DepartmentUsersInfoTab(
      {Key? key, required this.users, required this.superUsers})
      : super(
          key: key,
        );

  @override
  State<DepartmentUsersInfoTab> createState() => _DepartmentUsersInfoTabState();
}

class _DepartmentUsersInfoTabState extends State<DepartmentUsersInfoTab> {
  late List<Widget> usersListWidgets = [];
  late List<Widget> superUsersListWidgets = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      usersListWidgets = initUsersWidgetList(widget.users);
      superUsersListWidgets = initUsersWidgetList(widget.superUsers, true);
    });
  }

  List<Widget> initUsersWidgetList(List<User> users,
      [bool isSelected = false]) {
    late List<Widget> list = [];
    users.forEach((element) {
      list.add(UserTileCard(
        isSelected: isSelected,
        user: element,
      ));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: ScreenUtil().setHeight(15)),
        buildDepartmentInfoSectionTile(
          icon: Icons.supervisor_account_rounded,
          infoTitle: 'Department Supervisors : ',
          infoValue: '',
        ),
        CustomDividorLine(),
        Column(
          children: superUsersListWidgets,
        ),
        SizedBox(height: ScreenUtil().setHeight(15)),
        buildDepartmentInfoSectionTile(
          icon: Icons.people_rounded,
          infoTitle: 'Department Users : ',
          infoValue: '',
        ),
        CustomDividorLine(),
        Column(
          children: usersListWidgets,
        ),
      ],
    );
  }

  Widget buildDepartmentInfoSectionTile({
    required String infoTitle,
    required IconData icon,
    required String infoValue,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                infoTitle,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: ScreenUtil().setWidth(8)),
              Text(
                infoValue,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(width: ScreenUtil().setWidth(4)),
          Icon(
            icon,
            color: Colors.black,
            size: ScreenUtil().setSp(20),
          ),
        ],
      ),
    );
  }
}
