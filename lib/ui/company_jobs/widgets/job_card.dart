import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/common_widgets/app_snack_bar.dart';
import '../../../common/common_widgets/commonDialog/confirm_process_Dialog.dart';
import '../../../common/theme_helper.dart';
import '../../../models/job.dart';
import '../bloc/job_bloc.dart';
import '../pages/job_details_page.dart';
import 'edit_job.dart';

class JobCard extends StatefulWidget {
  final Job jobDetails;
  final int index;
  final Function deletingJobCallBack;
  const JobCard(
      {Key? key,
      required this.jobDetails,
      required this.deletingJobCallBack,
      required this.index})
      : super(key: key);

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  late Job jobInfo;
  @override
  void initState() {
    super.initState();
    jobInfo = widget.jobDetails;
  }

  listenToEdittingJob(Job newValue) {
    setState(() {
      jobInfo = newValue;
    });
  }

  final JobBloc jobBloc = JobBloc();
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: jobBloc,
      listener: (context, state) {
        if (state is ErrorDelettingJob) {
          ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
              message: 'Faild Deletting Job !', context: context));
        } else if (state is SuccessDelettingJob) {
          setState(() {
            widget.deletingJobCallBack(widget.index);
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(5),
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
                            jobInfo.name,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: ScreenUtil().setSp(17),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          BlocBuilder(
                            bloc: jobBloc,
                            builder: (context, state) {
                              if (state is DelettingJob) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                    strokeWidth: ScreenUtil().setWidth(3),
                                  ),
                                );
                              }
                              return IconButton(
                                onPressed: () => showConfeirmProcessAlert(
                                  context: context,
                                  cancelProcessFun: () {
                                    Navigator.of(context).pop();
                                  },
                                  submitProcessFun: () {
                                    Navigator.of(context).pop();
                                    jobBloc.add(DeleteJob(jobInfo.id));
                                  },
                                  prcessedText:
                                      "Are You Sure Want To Delete this Job Card ?",
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
                              );
                            },
                          ),
                          BlocBuilder(
                            bloc: jobBloc,
                            builder: (context, state) {
                              if (state is EdittingJob) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                    strokeWidth: ScreenUtil().setWidth(3),
                                  ),
                                );
                              }
                              return EditJobForm(
                                jobInfo: jobInfo,
                                edittingJobCallBack: listenToEdittingJob,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Text(
                    jobInfo.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  buildDetailsButton(jobInfo),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Align buildDetailsButton(Job jobDetails) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => JobDetailsPage(
                        jobDetails: jobDetails,
                      )));
        },
        child: Container(
          height: ScreenUtil().setHeight(40),
          width: ScreenUtil().setWidth(75),
          decoration: ThemeHelper().buttonBoxDecoration(context: context),
          child: Center(
            child: Text(
              'Details',
              style: GoogleFonts.belleza(
                fontStyle: FontStyle.normal,
                textStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
