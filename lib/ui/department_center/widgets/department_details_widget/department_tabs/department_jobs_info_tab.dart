import 'package:erb_mobo/models/job.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/common_widgets/CardTilesWidgets/job_card_tile.dart';

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
        return JobCardTile(job:jobs[index]);
      },
    );
  }

 
}
