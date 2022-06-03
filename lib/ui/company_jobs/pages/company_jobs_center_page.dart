import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/common_widgets/app_drawer.dart';
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
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: commonAppBar(
          context: context,
          title: 'Jobs Center',
          actions: [
            CreateNewJob(jobListCallBack: listenCreateNewJob),
          ],
        ),
        drawer: const AppDrawer(),
        body: BlocListener(
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
              ? Center(
                  child: Container(
                    height: ScreenUtil().setHeight(100),
                    width: double.infinity,
                    child: FlareActor(
                      "assets/flare/Progress Indicator.flr",
                      animation: "Loading",
                      color: Colors.black,
                      sizeFromArtboard: true,
                      fit: BoxFit.contain,
                      shouldClip: false,
                    ),
                  ),
                )
              : BlocBuilder(
                  bloc: jobBloc,
                  builder: (context, state) {
                    if (state is SuccessGettingJobs) {
                      state.jobs.reversed.toList();
                      return jobs.length == 0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: ScreenUtil().setHeight(180),
                                  width: double.infinity -
                                      ScreenUtil().setWidth(20),
                                  child: FlareActor(
                                    "assets/flare/empty2.flr",
                                    animation: "empty",
                                    sizeFromArtboard: true,
                                    shouldClip: false,
                                    fit: BoxFit.contain,
                                  ),
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
                                        // height: 1.5,
                                      ),
                                    ),
                                    SizedBox(
                                        height: ScreenUtil().setHeight(20)),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(15),
                                      ),
                                      child: CreateNewJob(
                                        jobListCallBack: listenCreateNewJob,
                                        childWidget: Container(
                                          decoration: ThemeHelper()
                                              .buttonBoxDecoration(
                                                  context: context),
                                          padding: EdgeInsets.symmetric(
                                            vertical: ScreenUtil().setHeight(9),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'add new one'.toUpperCase(),
                                              style: GoogleFonts.belleza(
                                                fontStyle: FontStyle.normal,
                                                textStyle: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(26),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          : ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return JobCard(
                                  jobDetails: jobs[index],
                                  index: index,
                                  deletingJobCallBack: listenDelettingJob,
                                );
                              },
                              itemCount: jobs.length,
                            );
                    } else if (state is ErrorGettingJobs) {
                      return const Center(
                        child: Text('some thing is wrong'),
                      );
                    }
                    return Container();
                  },
                ),
        ),
      ),
    );
  }
}
