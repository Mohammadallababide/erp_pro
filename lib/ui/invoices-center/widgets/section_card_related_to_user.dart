import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/user.dart';

class ScetionCardRelatedToUser extends StatelessWidget {
  final User? userInfoRealted;
  final String title;
  const ScetionCardRelatedToUser({
    Key? key,
    required this.userInfoRealted,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSectionCardRelatedToUser(context);
  }

  /// [buildSectionCardRelatedToUser] represent to show invoice info card related to user like [submited by , reviwed by , payment by ,...]

  Widget buildSectionCardRelatedToUser(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Icon(
                Icons.account_circle,
                color: Theme.of(context).primaryColor,
                size: ScreenUtil().setSp(25),
              )
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(15),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: userInfoRealted == null
                ? Text(
                    'not selected yet',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.w500),
                  )
                : Row(
                    children: [
                      Container(
                        height: ScreenUtil().setSp(25),
                        width: ScreenUtil().setSp(25),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2),
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
                        userInfoRealted!.firstName +
                            ' ' +
                            userInfoRealted!.lastName,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
          ),
          buildCusDividorLine(context),
        ],
      ),
    );
  }

  Widget buildCusDividorLine(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(30),
      height: ScreenUtil().setHeight(20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
