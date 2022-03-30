import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/common_widgets/app_snack_bar.dart';
import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../common/theme_helper.dart';
import '../../../models/assignJob.dart';
import '../../../models/user.dart';
import '../../company_jobs/bloc/job_bloc.dart';
import '../widgets/edit_job_assign_base_form.dart';
import '../widgets/job_assign_base_form.dart';

class AssignJobCenterPage extends StatefulWidget {
  final User user;
  final int? jobId;
  final String? jobLevel;
  const AssignJobCenterPage(
      {Key? key, required this.user, this.jobId, this.jobLevel})
      : super(key: key);

  @override
  State<AssignJobCenterPage> createState() => _AssignJobCenterPageState();
}

class _AssignJobCenterPageState extends State<AssignJobCenterPage> {
  late JobAssign? jobAssign;
  final JobBloc jobBloc = JobBloc();
  listenToAssignJobInfoChange(JobAssign newValue) {
    setState(() {
      jobAssign = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context: context,
        title: 'Assign Job Center',
        // automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(25),
          left: ScreenUtil().setWidth(10),
          right: ScreenUtil().setWidth(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(5),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: ScreenUtil()
                                      .setSp(ScreenUtil().radius(15) * 2),
                                  width: ScreenUtil()
                                      .setSp(ScreenUtil().radius(15) * 2),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.2),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                          'assets/images/useric.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(width: ScreenUtil().setWidth(8)),
                                Text(
                                  widget.user.firstName +
                                      ' ' +
                                      widget.user.lastName,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: ScreenUtil().setSp(17),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Theme.of(context).primaryColor,
                              size: ScreenUtil().setSp(22),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        widget.jobId == null
                            ? JobAssignBaseForm(
                                assignJobInfoCallBack:
                                    listenToAssignJobInfoChange,
                              )
                            : EditJobAssignBaseForm(
                                assignJobInfoCallBack:
                                    listenToAssignJobInfoChange,
                                jobId: widget.jobId!,
                                level: widget.jobLevel!),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            BlocListener(
              bloc: jobBloc,
              listener: (context, state) {
                if (state is ErrorAssignJobToUser) {
                  getAppSnackBar(
                    message: 'Faild assign Job',
                    context: context,
                  );
                } else if (state is SuccessAssignJobToUser) {
                  Navigator.pop(context);
                }
              },
              child: BlocBuilder(
                bloc: jobBloc,
                builder: (context, state) {
                  if (state is AssigningJobToUser) {
                    return Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                            strokeWidth: ScreenUtil().setWidth(3),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(15),
                          ),
                        ],
                      ),
                    );
                  }
                  return buildSubmitButton();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSubmitButton() {
    return Container(
      decoration: ThemeHelper().buttonBoxDecoration(context: context),
      child: ElevatedButton(
        style: ThemeHelper().buttonStyle(),
        child: Center(
          child: Text(
            'sumbit'.toUpperCase(),
            style: GoogleFonts.belleza(
              fontStyle: FontStyle.normal,
              textStyle: TextStyle(
                fontSize: ScreenUtil().setSp(26),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        onPressed: () {
          if (jobAssign != null) {
            jobBloc.add(
              AssignJobToUser(
                userId: widget.user.id!,
                jobId: jobAssign!.job!.id,
                level: jobAssign!.level!,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              getAppSnackBar(
                message: 'some info not complate yet!!',
                context: context,
              ),
            );
          }
        },
      ),
    );
  }
}
