import 'package:erb_mobo/models/assignJob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/costant.dart';
import '../../../models/job.dart';
import '../../company_jobs/bloc/job_bloc.dart';

class EditJobAssignBaseForm extends StatefulWidget {
  final Function assignJobInfoCallBack;
  final int jobId;
  final String level;
  EditJobAssignBaseForm({
    Key? key,
    required this.assignJobInfoCallBack,
    required this.jobId,
    required this.level,
  }) : super(key: key);

  @override
  State<EditJobAssignBaseForm> createState() => _EditJobAssignBaseFormState();
}

class _EditJobAssignBaseFormState extends State<EditJobAssignBaseForm> {
  late JobAssign jobAssign = JobAssign();
  final JobBloc jobBloc = JobBloc();
  late int jobSelectedIndex = 1000;
  late int levelSelectedIndex = 1000;
  @override
  void initState() {
    super.initState();

    jobBloc.add(
      GetJobs(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildJobAssignDetails(
          title: 'Job Title',
          getValue:
              jobAssign.job != null ? jobAssign.job!.name : 'Loadding ...',
          isLevelTile: false,
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        buildJobAssignDetails(
          title: 'Job Level',
          getValue: jobAssign.level != null ? jobAssign.level! : 'Loadding ...',
          isLevelTile: true,
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        jobAssign.job != null
            ? buildJobDescraption(
                title: 'Job Descraption',
                getValue: jobAssign.job!.description,
              )
            : Container(),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
      ],
    );
  }

  Widget buildJobDescraption({
    required String getValue,
    required String title,
  }) =>
      Padding(
          padding: EdgeInsets.only(
            bottom: ScreenUtil().setHeight(25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.yanoneKaffeesatz(
                      fontStyle: FontStyle.normal,
                      textStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(22),
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.info,
                    color: Theme.of(context).primaryColor,
                    size: ScreenUtil().setSp(22),
                  )
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(5),
              ),
              Text(
                getValue,
                maxLines: null,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil().setSp(15),
                  height: ScreenUtil().setHeight(1.5),
                ),
              ),
            ],
          ));

  buildJobAssignDetails(
      {required String getValue,
      required String title,
      required bool isLevelTile}) {
    return BlocListener(
        bloc: jobBloc,
        listener: (context, state) {
          if (state is SuccessGettingJobs) {
            setState(() {
              jobAssign.job = state.jobs[state.jobs
                  .indexWhere((element) => element.id == widget.jobId)];
              jobSelectedIndex =
                  state.jobs.indexWhere((e) => e.id == widget.jobId);
              levelSelectedIndex = ConstatValues.companyJobLevels
                  .indexWhere((e) => e == widget.level);
              jobAssign.level = widget.level;
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.only(
            bottom: ScreenUtil().setHeight(25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.yanoneKaffeesatz(
                  fontStyle: FontStyle.normal,
                  textStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(22),
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                width: MediaQuery.of(context).size.width -
                    ScreenUtil().setWidth(30),
                height: ScreenUtil().setHeight(45),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.5,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        getValue,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                          height: ScreenUtil().setHeight(1.5),
                        ),
                      ),
                    ),
                    isLevelTile
                        ? IconButton(
                            onPressed: () {
                              showLevels();
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: Theme.of(context).primaryColor,
                              size: ScreenUtil().setSp(37),
                            ),
                          )
                        : BlocBuilder(
                            bloc: jobBloc,
                            builder: (context, state) {
                              if (state is SuccessGettingJobs) {
                                return IconButton(
                                  onPressed: () {
                                    showCompanyJobsList(state.jobs);
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Theme.of(context).primaryColor,
                                    size: ScreenUtil().setSp(37),
                                  ),
                                );
                              } else if (state is GettingJobs) {
                                return Icon(
                                  Icons.access_time,
                                  color: Colors.blueAccent,
                                  size: ScreenUtil().setSp(22),
                                );
                              } else if (state is ErrorGettingJobs) {
                                return Icon(
                                  Icons.access_time_filled_outlined,
                                  color: Colors.deepOrange,
                                  size: ScreenUtil().setSp(22),
                                );
                              }
                              return Container();
                            })
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> showLevels() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(25),
                vertical: ScreenUtil().setHeight(10)),
            child: SingleChildScrollView(
              child: ListBody(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Center(
                    child: Text(
                      'Assign Job Level',
                      style: GoogleFonts.yanoneKaffeesatz(
                        fontStyle: FontStyle.normal,
                        textStyle: TextStyle(
                          fontSize: ScreenUtil().setSp(27),
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Container(
                    height: ScreenUtil().setHeight(300),
                    child: ListView.builder(
                      itemCount: ConstatValues.companyJobLevels.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildLevelTile(
                          level: ConstatValues.companyJobLevels[index],
                          index: index,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showCompanyJobsList(List<Job> jobs) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(25),
                vertical: ScreenUtil().setHeight(10)),
            child: SingleChildScrollView(
              child: ListBody(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Center(
                    child: Text(
                      'Company Jobs List',
                      style: GoogleFonts.yanoneKaffeesatz(
                        fontStyle: FontStyle.normal,
                        textStyle: TextStyle(
                          fontSize: ScreenUtil().setSp(27),
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Container(
                    height: ScreenUtil().setHeight(400),
                    child: ListView.builder(
                      itemCount: jobs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildJobListTile(jobs[index], index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Column buildLevelTile({required String level, required int index}) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            setState(() {
              jobAssign.level = level;
              widget.assignJobInfoCallBack(jobAssign);
              levelSelectedIndex = index;
            });
            Navigator.pop(context);
          },
          trailing: index == levelSelectedIndex
              ? Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: ScreenUtil().setSp(22),
                )
              : Icon(
                  Icons.check_circle,
                  color: Colors.grey,
                  size: ScreenUtil().setSp(22),
                ),
          title: Text(
            level,
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(
          thickness: 2,
          color: Colors.black,
        ),
      ],
    );
  }

  Column buildJobListTile(Job job, int index) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            setState(() {
              jobAssign.job = job;
              widget.assignJobInfoCallBack(jobAssign);
              jobSelectedIndex = index;
            });
            Navigator.pop(context);
          },
          trailing: index == jobSelectedIndex
              ? Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: ScreenUtil().setSp(22),
                )
              : Icon(
                  Icons.check_circle,
                  color: Colors.grey,
                  size: ScreenUtil().setSp(22),
                ),
          title: Text(
            job.name,
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            job.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Divider(
          thickness: 2,
          color: Colors.black,
        ),
      ],
    );
  }
}
