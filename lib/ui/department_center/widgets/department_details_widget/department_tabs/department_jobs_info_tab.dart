import 'package:erb_mobo/models/job.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DepartmentJobsInfoTab extends StatelessWidget {
  final List<Job> jobs;
  const DepartmentJobsInfoTab({Key? key, required this.jobs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(5),
        vertical: ScreenUtil().setHeight(10),
      ),
      itemCount: jobs.length,
      itemBuilder: (BuildContext context, int index) {
        return jobListTile(jobs[index], context);
      },
    );
  }

  Widget jobListTile(Job job, BuildContext context) {
    return ListTile(
      title: Text(
        job.name,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(14)),
      ),
      subtitle: Text(job.description),
      leading: Icon(
        Icons.business_center,
        color: Colors.grey,
        size: ScreenUtil().setSp(30),
      ),
      trailing: Icon(
        Icons.check_circle,
        color: Theme.of(context).primaryColor,
        size: ScreenUtil().setSp(20),
      ),
    );
  }
}
