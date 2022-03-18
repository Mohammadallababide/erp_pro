import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/common_widgets/app_drawer.dart';
import '../../../common/common_widgets/app_snack_bar.dart';
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
    jobBloc.add(GetJobs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        listener: (context, state) {
          if (state is ErrorGettingJobs) {
            ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
                message: 'Faild Getting Jobs !', context: context));
          } else if (state is SuccessGettingJobs) {
            setState(() {
              jobs = state.jobs.reversed.toList();
            });
          }
        },
        child: BlocBuilder(
          bloc: jobBloc,
          builder: (context, state) {
            if (state is GettingJobs) {
              return SizedBox(
                height: MediaQuery.of(context).size.height -
                    ScreenUtil().setHeight(210),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    strokeWidth: ScreenUtil().setWidth(3),
                  ),
                ),
              );
            } else if (state is SuccessGettingJobs) {
              state.jobs.reversed.toList();
              return jobs.length == 0
                  ? Center(
                      child: Text('No Company Jobs Yet'),
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
              return SizedBox(
                height: MediaQuery.of(context).size.height -
                    ScreenUtil().setHeight(210),
                child: const Center(
                  child: Text('some thing is wrong'),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
