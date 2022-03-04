import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/generate_screen.dart';
import '../../../../common/theme_helper.dart';
import '../UsersListForAsignmentSalary/user_card_tile.dart';

Column buildSalaryAsignmentUserSection(BuildContext context) {
  return Column(
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Salary Asignment To :',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(15),
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      SizedBox(
        height: ScreenUtil().setHeight(15),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: ScreenUtil().setSp(25),
                  width: ScreenUtil().setSp(25),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Image(
                    image: AssetImage('assets/images/useric.png'),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(7),
                ),
                Text(
                  "Mohammad Al lababidi",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            InkWell(
              onTap: () => _showUsersListForAsignment(context),
              child: Container(
                height: ScreenUtil().setHeight(40),
                width: ScreenUtil().setWidth(75),
                decoration: ThemeHelper().buttonBoxDecoration(context: context),
                child: Center(
                  child: Text(
                    'Change',
                    style: GoogleFonts.belleza(
                      fontStyle: FontStyle.normal,
                      textStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Future<void> _showUsersListForAsignment(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: ScreenUtil().setHeight(350),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(10),
                    top: ScreenUtil().setHeight(10),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Salary Asignment To :",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: ScreenUtil().setSp(20)),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(15)),
                Expanded(
                  child: ListView(
                    children: [
                      UserTileCard(),
                      UserTileCard(),
                      UserTileCard(),
                      UserTileCard(),
                      UserTileCard(),
                      UserTileCard(),
                      UserTileCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
