import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common/common_widgets/custom_dividor_line.dart';
import '../../../../../core/utils/core_util_function.dart';
import '../../../../../models/department.dart';

// ignore: must_be_immutable
class DepartmentOverViewInfoTab extends StatelessWidget {
  final Department department;
  DepartmentOverViewInfoTab({Key? key, required this.department})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(5),
        vertical: ScreenUtil().setHeight(10),
      ),
      children: [
        buildOverViewDetailsCard(context),
      ],
    );
  }

  Column buildDepartmentCardBodyInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              Icons.info,
              color: Theme.of(context).primaryColor,
              size: ScreenUtil().setSp(20),
            ),
            Text(
              ' Department Infomations : ',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenUtil().setHeight(15)),
        buildDepartmentInfoSectionTile(
            icon: Icons.account_tree_outlined,
            infoTitle: 'Department Title : ',
            infoValue: department.title),
        CustomDividorLine(),
        SizedBox(height: ScreenUtil().setHeight(15)),
        buildDepartmentInfoSectionTile(
          icon: Icons.access_time_filled,
          infoTitle: 'Created At : ',
          infoValue: "${CorerUtilFunction.getFormalDate(
            '2022-05-18',
          )}",
        ),
        CustomDividorLine(),
        SizedBox(height: ScreenUtil().setHeight(15)),
        buildDepartmentInfoSectionTile(
            icon: Icons.people_outline,
            infoTitle: 'Max Employees Count : ',
            infoValue: department.maxNumberOfEmployees.toString()),
        CustomDividorLine(),
        SizedBox(height: ScreenUtil().setHeight(15)),
        buildDepartmentInfoSectionTile(
            icon: Icons.people_rounded,
            infoTitle: 'Employees Count : ',
            infoValue: department.users.length.toString()),
        CustomDividorLine(),
        SizedBox(height: ScreenUtil().setHeight(15)),
        buildDepartmentInfoSectionTile(
            icon: Icons.business_center,
            infoTitle: 'Jobs Count : ',
            infoValue: department.jobs.length.toString()),
        CustomDividorLine(),
        SizedBox(height: ScreenUtil().setHeight(15)),
      ],
    );
  }

  Widget buildDepartmentInfoSectionTile({
    required String infoTitle,
    required IconData icon,
    required String infoValue,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                infoTitle,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: ScreenUtil().setWidth(8)),
              Text(
                infoValue,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(width: ScreenUtil().setWidth(4)),
          Icon(
            icon,
            color: Colors.black,
            size: ScreenUtil().setSp(20),
          ),
        ],
      ),
    );
  }

  Widget buildOverViewDetailsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ScreenUtil().radius(15),
          ),
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(7),
              vertical: ScreenUtil().setHeight(10),
            ),
            child: buildDepartmentCardBodyInfoSection(context)),
      ),
    );
  }
}
