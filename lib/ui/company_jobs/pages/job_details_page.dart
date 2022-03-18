import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../common/common_widgets/commonDialog/confirm_process_Dialog.dart';
import '../../../models/job.dart';

class JobDetailsPage extends StatelessWidget {
  final Job jobDetails;
  const JobDetailsPage({
    Key? key,
    required this.jobDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: 'Job Details', context: context, actions: [
        IconButton(
          onPressed: () => showConfeirmProcessAlert(
            context: context,
            cancelProcessFun: () {
              Navigator.of(context).pop();
            },
            submitProcessFun: () {
              Navigator.of(context).pop();
            },
            prcessedText: "Are You Sure Want To Delete this Job Card ?",
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          iconSize: ScreenUtil().setSp(25),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          iconSize: ScreenUtil().setSp(25),
        ),
      ]),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(10),
              vertical: ScreenUtil().setHeight(5)
            ),
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                    vertical: ScreenUtil().setHeight(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height:
                                ScreenUtil().setSp(ScreenUtil().radius(15) * 2),
                            width:
                                ScreenUtil().setSp(ScreenUtil().radius(15) * 2),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage('assets/images/job.png'),
                              ),
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(8)),
                          Text(
                            jobDetails.name,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: ScreenUtil().setSp(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                       SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Text(
                      jobDetails.description,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
