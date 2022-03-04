import 'package:erb_mobo/common/common_widgets/commomn_app_bar.dart';
import 'package:erb_mobo/ui/my_profile/bloc/myprofilebloc_bloc.dart';
import 'package:erb_mobo/ui/my_profile/widgets/PersonalDetailsWidgets/user_personal_info.dart';
import 'package:erb_mobo/ui/my_profile/widgets/receipt_List.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/common_widgets/app_drawer.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    myprofileblocBloc.add(FetchMyProfileInfo());
    super.initState();
  }

  final MyprofileblocBloc myprofileblocBloc = MyprofileblocBloc();
  late int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: commonAppBar(context: context, title: 'my Profile'),
        drawer: const AppDrawer(),
        body: _selectedIndex == 0
            ? UserPersonalInfo(myprofileblocBloc: myprofileblocBloc)
            : ReceiptList(myprofileblocBloc: myprofileblocBloc),
        bottomNavigationBar: buildBottomBar(),
      ),
    );
  }

  Widget buildBottomBar() {
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
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            enableFeedback: false,
            backgroundColor: Theme.of(context).primaryColor,
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
                label: 'Receipts Info',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
