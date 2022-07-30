import 'package:erb_mobo/ui/user_profile/widgets/personalInfoWidgets/salary_info_card.dart';
import 'package:erb_mobo/ui/user_profile/widgets/userProfilePageWidgets/profile_header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/user.dart';
import '../personalInfoWidgets/personal_info_card.dart';
import 'card_info.dart';

class ProfileContent extends StatelessWidget {
  final User user;
  const ProfileContent({
    Key? key, required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(65),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(15),
      ),
      child: Column(
        children: [
          ProfileHeaderSection(user:user),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          PersonalInfoCard(user: user),
          SalaryInfoCard(user: user),
          CardInfo(
            title: 'leaves info',
            icon: Icons.beach_access_rounded,
          ),
          CardInfo(
            title: 'work info',
            icon: Icons.business_center_rounded,
          ),
        ],
      ),
    );
  }
}
