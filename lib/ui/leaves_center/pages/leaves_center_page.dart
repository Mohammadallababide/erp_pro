import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common_widgets/app_drawer.dart';
import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../common/generate_screen.dart';

class LeavesCenter extends StatelessWidget {
  const LeavesCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: commonAppBar(
          context: context,
          title: 'Leaves Center',
        ),
        drawer: const AppDrawer(),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              heroTag: null,
              child: Center(
                child: Icon(Icons.category_outlined,
                    color: Colors.white, size: ScreenUtil().setSp(25)),
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                NameScreen.leavesCategoriesPage,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(5),
            ),
            FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              heroTag: null,
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: ScreenUtil().setSp(30),
                ),
              ),
              onPressed: () => () {
                Navigator.pushNamed(
                  context,
                  NameScreen.createLeaveRequestPage,
                );
              },
            ),
          ],
        ),
        body: Container(),
      ),
    );
  }
}
