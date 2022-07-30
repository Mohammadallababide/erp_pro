import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/costant.dart';
import '../../../../models/user.dart';

class ProfileHeaderSection extends StatelessWidget {
  final User user;
  const ProfileHeaderSection({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: ScreenUtil().setSp(32),
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtil().setHeight(2.5),
        ),
        CircleAvatar(
          radius: ScreenUtil().radius(60),
          backgroundImage: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlgVUiuTQbmj_jO_W1nmX8bzbXS2DDxMStn8FdSPyK7SSAKVnHXZjTx9764JdwzGSWd84&usqp=CAU'),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        Text(
          user.firstName + ' ' + user.lastName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(10.w * 1.7),
              fontWeight: FontWeight.w800,
              color: Colors.white),
        ),
        SizedBox(height: ScreenUtil().setHeight(5)),
        Text(
          user.email,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(10.w * 1.4),
              fontWeight: FontWeight.w600,
              color: Colors.white30),
        ),
        SizedBox(height: ScreenUtil().setHeight(15)),
        Container(
          decoration: BoxDecoration(
            gradient: ConstatValues.baseGradientColor,
            borderRadius: BorderRadius.circular(
              ScreenUtil().radius(15),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(17),
              vertical: ScreenUtil().setHeight(8),
            ),
            child: Text(
              user.roles != null ? user.roles!.first : 'Not Selected Yet',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(16.5),
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(10)),
        Divider(
          thickness: 2, // thickness of the line
          indent: ScreenUtil().setSp(35),
          endIndent: ScreenUtil().setSp(35),
          color: Colors.white,
          height: ScreenUtil().setHeight(25),
        ),
      ],
    );
  }
}
