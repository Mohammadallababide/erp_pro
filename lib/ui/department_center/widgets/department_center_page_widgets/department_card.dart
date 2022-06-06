import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

import '../../../../common/generate_screen.dart';
import '../../../../core/utils/core_util_function.dart';
import '../../../../models/department.dart';

class DepartmentCard extends StatelessWidget {
  final Department department;
  final int index;
  const DepartmentCard(
      {Key? key, required this.department, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, NameScreen.departmentDetailsPage,
            arguments: {'department': department});
      },
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(7),
            vertical: ScreenUtil().setHeight(10),
          ),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                ScreenUtil().radius(15),
              ),
            ),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(7),
                vertical: ScreenUtil().setHeight(10),
              ),
              child: Column(
                children: [
                  buildDepartmentCardHeaderSection(context),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  buildDepartmentCardBodyInfoSection(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column buildDepartmentCardBodyInfoSection(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.info,
              color: Theme.of(context).primaryColor,
              size: ScreenUtil().setSp(20),
            ),
            SizedBox(width: ScreenUtil().setWidth(4)),
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
        SizedBox(height: ScreenUtil().setHeight(12)),
        buildDepartmentInfoSectionTile(
            icon: Icons.location_history,
            infoTitle: 'Employees Count : ',
            infoValue: department.users.length.toString()),
        SizedBox(height: ScreenUtil().setHeight(12)),
        buildDepartmentInfoSectionTile(
            icon: Icons.business_center,
            infoTitle: 'Jobs Count : ',
            infoValue: department.jobs.length.toString()),
      ],
    );
  }

  Padding buildDepartmentInfoSectionTile({
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
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.w700,
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

  Row buildDepartmentCardHeaderSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: ScreenUtil().setHeight(14),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setSp(150),
                  ),
                  child: Center(
                    child: Text(
                      index.toString(),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: ScreenUtil().setWidth(8)),
            Text(
              department.title,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: ScreenUtil().setSp(17),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "${CorerUtilFunction.getFormalDate(
                '2022-05-18',
              )}",
              textDirection: ui.TextDirection.ltr,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(12),
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(8),
            ),
            Icon(
              Icons.access_time_filled,
              color: Theme.of(context).primaryColor,
              size: ScreenUtil().setSp(14),
            ),
          ],
        ),
      ],
    );
  }
}
