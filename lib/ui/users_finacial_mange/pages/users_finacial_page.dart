import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/common_widgets/app_drawer.dart';
import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../common/generate_screen.dart';
import '../../../common/theme_helper.dart';
import '../widgets/UsersFinacialPage/cus_filter_button.dart';
import '../widgets/UsersFinacialPage/user_finacial_card.dart';

class UsersFinacialPage extends StatelessWidget {
  const UsersFinacialPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar:
            commonAppBar(context: context, title: 'Users Finacial Mangment'),
        drawer: const AppDrawer(),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(15),
                vertical: ScreenUtil().setHeight(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, NameScreen.createUserReceiptPage);
                    },
                    child: Container(
                      width: ScreenUtil().setWidth(110),
                      height: ScreenUtil().setHeight(50),
                      decoration: ThemeHelper().buttonBoxDecoration(
                        context: context,
                        radius: ScreenUtil().setSp(15),
                      ),
                      child: Center(
                        child: Text(
                          'New Salary',
                          style: GoogleFonts.belleza(
                            fontStyle: FontStyle.normal,
                            textStyle: TextStyle(
                              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const CusFilterButton(),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                // padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(80)),
                children: const [
                  UserFinacialCard(),
                  UserFinacialCard(),
                  UserFinacialCard(),
                  UserFinacialCard(),
                ],
              ),
            ),
          ],
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(
        //     Icons.add,
        //     color: Colors.white,
        //     size: ScreenUtil().setSp(35),
        //   ),
        //   backgroundColor: Theme.of(context).primaryColor,
        //   onPressed: () {

        //   },
        // ),
      ),
    );
  }
}
