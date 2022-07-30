import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../models/user.dart';
import '../shared/bottom_sheet_widgets/header_of_bottom_sheet.dart';
import '../shared/bottom_sheet_widgets/info_section_row.dart';
import '../userProfilePageWidgets/card_info.dart';

class PersonalInfoCard extends StatelessWidget {
  final User user;
  const PersonalInfoCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openBottomSheetContent(context),
      child: CardInfo(
        title: 'personal info',
        icon: Icons.account_circle,
      ),
    );
  }

  openBottomSheetContent(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(ScreenUtil().radius(20)),
          topStart: Radius.circular(ScreenUtil().radius(20)),
        ),
      ),
      builder: (context) => SingleChildScrollView(
          padding: EdgeInsetsDirectional.only(
            start: ScreenUtil().setWidth(10),
            end: ScreenUtil().setWidth(10),
            bottom: 30,
            top: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderOfBottomSheet(
                  title: 'Personal Info', icon: Icons.account_circle),
              SizedBox(
                height: ScreenUtil().setHeight(5),
              ),
              InfoSectionRow(title: 'First Name :', value: user.firstName),
              InfoSectionRow(title: 'Last Name :', value: user.lastName),
              InfoSectionRow(title: 'Email :', value: user.email),
              InfoSectionRow(
                  title: 'phone Number :',
                  value: user.phoneNumber ?? 'not found yet',
                  isBottomPadding: false),
            ],
          )),
    );
  }
}
