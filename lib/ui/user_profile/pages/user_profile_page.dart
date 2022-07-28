import 'package:erb_mobo/ui/user_profile/bloc/user_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/costant.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserProfileBloc userProfileBloc = UserProfileBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: ConstatValues.baseGradientColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(65),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(15),
          ),
          child: Column(
            children: [
              buildHeaderSection(),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              buildCardSectionInfo(
                title: 'personal info',
                context: context,
                icon: Icons.account_circle,
              ),
              buildCardSectionInfo(
                title: 'salary info',
                context: context,
                icon: Icons.attach_money_rounded,
              ),
              buildCardSectionInfo(
                title: 'leaves info',
                context: context,
                icon: Icons.beach_access_rounded,
              ),
              buildCardSectionInfo(
                title: 'work info',
                context: context,
                icon: Icons.business_center_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardSectionInfo({
    required BuildContext context,
    required String title,
    required IconData icon,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(20),
      ),
      child: Container(
        height: ScreenUtil().setHeight(55),
        width: ScreenUtil().setWidth(300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            ScreenUtil().radius(30),
          ),
          color: Colors.white.withOpacity(0.4),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: ScreenUtil().setSp(25),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(10),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).primaryColor,
                size: ScreenUtil().setSp(25),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildHeaderSection() {
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
          'Nicolas Adams',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(10.w * 1.7),
              fontWeight: FontWeight.w800,
              color: Colors.white),
        ),
        SizedBox(height: ScreenUtil().setHeight(5)),
        Text(
          'nicolasadams@gmail.com',
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
              'hr manger',
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
          indent: ScreenUtil().setSp(20),
          endIndent: ScreenUtil().setSp(20),
          color: Colors.grey,
          height: ScreenUtil().setHeight(25),
        ),
      ],
    );
  }
}
