import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/department.dart';

import '../widgets/department_details_widget/department_tabs/department_jobs_info_tab.dart';
import '../widgets/department_details_widget/department_tabs/department_overView_info_tab.dart';
import '../widgets/department_details_widget/department_tabs/department_users_info_tab.dart';

class DepartmentDetailsPage extends StatelessWidget {
  final Department department;
  DepartmentDetailsPage({Key? key, required this.department}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            title: const Text(
              'Department Details',
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size(
                0,
                ScreenUtil().setHeight(60),
              ),
              child: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.quiz),
                    text: 'overView',
                  ),
                  Tab(
                    icon: Icon(Icons.business_center),
                    text: 'department jobs',
                  ),
                  Tab(
                    icon: Icon(Icons.supervisor_account_rounded),
                    text: 'department users',
                  )
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              DepartmentOverViewInfoTab(
                department: department,
              ),
              DepartmentJobsInfoTab(
                jobs: department.jobs,
              ),
              DepartmentUsersInfoTab(
                users: department.users,
                superUsers: department.users,
              ),
            ],
          )),
    );
  }
}
