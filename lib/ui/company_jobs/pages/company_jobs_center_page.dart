import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/animationAppWidget.dart';
import '../../../common/common_widgets/app_drawer.dart';
import '../../../common/common_widgets/common_add_FLB.dart';
import '../../../common/common_widgets/common_scaffold_app.dart';
import '../../../common/common_widgets/custom_app_button.dart';
import '../../../common/theme_helper.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../models/job.dart';
import '../bloc/job_bloc.dart';
import '../widgets/create_new_job.dart';
import '../widgets/job_card.dart';

class CompanyJobsCenterPage extends StatefulWidget {
  const CompanyJobsCenterPage({Key? key}) : super(key: key);

  @override
  State<CompanyJobsCenterPage> createState() => _CompanyJobsCenterPageState();
}

class _CompanyJobsCenterPageState extends State<CompanyJobsCenterPage> {
  late List<Job> jobs = [];
  final JobBloc jobBloc = JobBloc();
  late bool isLoading;
  listenCreateNewJob(Job newValue) {
    setState(() {
      jobs.add(newValue);
    });
  }

  listenDelettingJob(int index) {
    setState(() {
      jobs.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    jobBloc.add(GetJobs());
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldApp(
      title: 'Jobs Center',
      actions: [
        CreateNewJob(jobListCallBack: listenCreateNewJob),
      ],
      flb: CreateNewJob(
        jobListCallBack: listenCreateNewJob,
        childWidget: CommonAddFLB(icon:Icons.add,),
      ),
      child: BlocListener(
        bloc: jobBloc,
        listener: (context, state) async {
          if (state is ErrorGettingJobs) {
            await Future.delayed(
              Duration(seconds: 3),
            );
            setState(() => isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
                message: 'Faild Getting Jobs !', context: context));
          } else if (state is SuccessGettingJobs) {
            await Future.delayed(
              Duration(seconds: 3),
            );
            setState(() {
              isLoading = false;
              jobs = state.jobs.toList();
            });
          }
        },
        child: isLoading
            ? AnimationAppWidget(
                name: AnimationWidgetNames.ProgressIndicator,
              )
            : BlocBuilder(
                bloc: jobBloc,
                builder: (context, state) {
                  if (state is SuccessGettingJobs) {
                    state.jobs.reversed.toList();
                    return jobs.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimationAppWidget(
                                name: AnimationWidgetNames.empty1,
                              ),
                              SizedBox(height: ScreenUtil().setHeight(20)),
                              Column(
                                children: [
                                  Text(
                                    'There is no jobs created yet!',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.bebasNeue(
                                      fontStyle: FontStyle.normal,
                                      textStyle: TextStyle(
                                        fontSize: ScreenUtil().setSp(25),
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(20)),
                                  CreateNewJob(
                                    jobListCallBack: listenCreateNewJob,
                                    childWidget: CustomAppButton(
                                      title: 'add new one',
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(5),
                            ),
                            child: ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return JobCard(
                                  jobDetails: jobs[index],
                                  index: index,
                                  deletingJobCallBack: listenDelettingJob,
                                );
                              },
                              itemCount: jobs.length,
                            ),
                          );
                  } else if (state is ErrorGettingJobs) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimationAppWidget(
                          name: AnimationWidgetNames.networkError,
                        ),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                        Text(
                          'There Some Thing Wrong!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.bebasNeue(
                            fontStyle: FontStyle.normal,
                            textStyle: TextStyle(
                              fontSize: ScreenUtil().setSp(25),
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                        InkWell(
                          onTap: () {
                            setState(() => {
                                  isLoading = true,
                                });
                            jobBloc.add(GetJobs());
                          },
                          child: CustomAppButton(
                            title: 'retry',
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
      ),
    );
  }
}
