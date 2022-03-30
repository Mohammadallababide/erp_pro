import 'package:erb_mobo/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/theme_helper.dart';
import '../../assign_commpany_job/page/assign_job_center_page.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ScreenUtil().setWidth(10),
        ScreenUtil().setHeight(5),
        ScreenUtil().setWidth(10),
        ScreenUtil().setHeight(5),
      ),
      child: Material(
        elevation: 0.3,
        borderRadius: BorderRadius.all(
          Radius.circular(
            ScreenUtil().radius(15),
          ),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(15),
            ScreenUtil().setHeight(3),
            ScreenUtil().setWidth(15),
            ScreenUtil().setHeight(3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: ScreenUtil().setSp(30),
                        width: ScreenUtil().setSp(30),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/useric.png',
                              ),
                              fit: BoxFit.contain,
                            )),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(8),
                      ),
                      Text(
                        user.firstName + ' ' + user.lastName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColor,
                        size: ScreenUtil().setSp(21),
                      ),
                      user.jobId == null
                          ? Row(
                              children: [
                                SizedBox(
                                  width: ScreenUtil().setWidth(8),
                                ),
                                Icon(
                                  Icons.warning_rounded,
                                  color: Color.fromARGB(255, 105, 83, 5),
                                  size: ScreenUtil().setSp(22),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: ScreenUtil().setWidth(4),
              ),
              Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                child: Text(
                  user.roles![0],
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(5),
              ),
              buildAssignOrEditJobButton(
                  context, user.jobId == null ? true : false),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Align buildAssignOrEditJobButton(
      BuildContext context, bool isAssignJobAction) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AssignJobCenterPage(
                user: user,
                jobId: user.jobId,
                jobLevel: user.level,
              ),
            ),
          );
        },
        child: Container(
          height: ScreenUtil().setHeight(35),
          width: ScreenUtil().setWidth(75),
          decoration: ThemeHelper().buttonBoxDecoration(context: context),
          child: Center(
            child: Text(
              !isAssignJobAction ? 'Edit Job' : 'Assign Job',
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
    );
  }
}
