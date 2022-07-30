import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/job.dart';

class JobCardTile extends StatelessWidget {
  final Job job;
  final Widget? actionsRow;
  const JobCardTile({Key? key, required this.job, this.actionsRow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        job.name,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(14)),
      ),
      subtitle: Text(
        job.description,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
     
      ),
      leading: Icon(
        Icons.business_center,
        color: Colors.grey,
        size: ScreenUtil().setSp(30),
      ),
      trailing: actionsRow ??
          Icon(
            Icons.check_circle,
            color: Theme.of(context).primaryColor,
            size: ScreenUtil().setSp(20),
          ),
    );
  }
}
