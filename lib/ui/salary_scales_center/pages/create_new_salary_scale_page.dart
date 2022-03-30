import 'package:erb_mobo/models/salary-scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/common_widgets/app_snack_bar.dart';
import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../common/theme_helper.dart';
import '../../../core/utils/costant.dart';
import '../../../core/validations/validtion.dart';
import '../../../models/job.dart';
import '../../../models/salary-scale-job.dart';
import '../../company_jobs/bloc/job_bloc.dart';
import '../bloc/salaryscales_bloc.dart';

class CreateNewSalaryScalePage extends StatefulWidget {
  const CreateNewSalaryScalePage({
    Key? key,
  }) : super(key: key);
  @override
  State<CreateNewSalaryScalePage> createState() =>
      _CreateNewSalaryScalePageState();
}

class _CreateNewSalaryScalePageState extends State<CreateNewSalaryScalePage> {
  List<SalaryScaleJob> salaryScaleJobs = [];
  late List<_FormData> formDateList = [];
  final JobBloc jobBloc = JobBloc();
  late SalaryScale creeatedSalarySclae;
  final SalaryScalesBloc salaryScalesBloc = SalaryScalesBloc();

  late int counter = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
        title: 'New Salary Scale',
      ),
      body: BlocBuilder(
        bloc: jobBloc,
        builder: (context, state) {
          if (state is GettingJobs) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
                strokeWidth: ScreenUtil().setWidth(3),
              ),
            );
          } else if (state is ErrorGettingJobs) {
            return Center(
              child: Text('some thing is wrong'),
            );
          } else if (state is SuccessGettingJobs) {
            return Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: state.jobs.length,
                      itemBuilder: (BuildContext context, int index) {
                        formDateList.add(
                          _FormData(
                            level: ConstatValues.companyJobLevels[0],
                            controller: TextEditingController(),
                            job: state.jobs[index],
                          ),
                        );

                        formDateList.add(
                          _FormData(
                            level: ConstatValues.companyJobLevels[1],
                            controller: TextEditingController(),
                            job: state.jobs[index],
                          ),
                        );

                        formDateList.add(
                          _FormData(
                            level: ConstatValues.companyJobLevels[2],
                            controller: TextEditingController(),
                            job: state.jobs[index],
                          ),
                        );
                        counter += 3;
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: ScreenUtil().setHeight(10),
                          ),
                          child: buildSlaryScaleForm(
                            jformData: formDateList[counter - 3],
                            sformData: formDateList[counter - 2],
                            eformData: formDateList[counter - 1],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(10),
                        horizontal: ScreenUtil().setWidth(10)),
                    child: BlocListener(
                      bloc: salaryScalesBloc,
                      listener: (context, state) {
                        if (state is SuccessCreattingSalaryScale) {
                          Navigator.pop(context, true);
                        } else if (state is ErrorCreattingSalaryScale) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              getAppSnackBar(
                                  message: 'Faild! complate process.',
                                  context: context));
                        }
                      },
                      child: BlocBuilder(
                        bloc: salaryScalesBloc,
                        builder: (context, state) {
                          if (state is CreattingSalaryScale) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                                strokeWidth: ScreenUtil().setWidth(3),
                              ),
                            );
                          }
                          return Container(
                            decoration: ThemeHelper()
                                .buttonBoxDecoration(context: context),
                            child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Center(
                                  child: Text(
                                    'submit'.toUpperCase(),
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
                                onPressed: () => submitForm()),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  void submitForm() {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      formDateList.forEach((element) {
        salaryScaleJobs.add(
          SalaryScaleJob(
            jobId: element.job.id,
            employeeLevel: element.level,
            amount: int.parse(
              element.controller.text,
            ),
          ),
        );
      });

      salaryScalesBloc.add(CreateSalaryScales(salaryScaleJobs));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
          message: 'info not completed yet!!', context: context));
    }
  }

  buildSlaryScaleForm({
    required _FormData jformData,
    required _FormData sformData,
    required _FormData eformData,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(7)),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ScreenUtil().radius(15),
          ),
        ),
        child: Column(children: [
          Container(
            height: ScreenUtil().setHeight(50),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ScreenUtil().radius(15)),
                  topRight: Radius.circular(ScreenUtil().radius(15)),
                )),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10),
                vertical: ScreenUtil().setHeight(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: ScreenUtil().setSp(ScreenUtil().radius(13) * 2),
                    width: ScreenUtil().setSp(ScreenUtil().radius(13) * 2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/job.png'),
                      ),
                    ),
                  ),
                  Text(
                    jformData.job.name,
                    style: GoogleFonts.yanoneKaffeesatz(
                      fontStyle: FontStyle.normal,
                      textStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(22),
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(10),
              vertical: ScreenUtil().setHeight(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Salary Amount For Levels: ',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(17),
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Row(
                  children: [
                    Text(
                      jformData.level,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(10),
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: (val) => Validation.nonEmptyField(val!),
                        textAlign: TextAlign.start,
                        controller: jformData.controller,
                        decoration: InputDecoration(
                          filled: true,
                          isDense: true,
                          border: UnderlineInputBorder(),
                          labelText: 'Enter value',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Row(
                  children: [
                    Text(
                      sformData.level,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(10),
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: (val) => Validation.nonEmptyField(val!),
                        textAlign: TextAlign.start,
                        controller: sformData.controller,
                        decoration: InputDecoration(
                          filled: true,
                          isDense: true,
                          border: UnderlineInputBorder(),
                          labelText: 'Enter value',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Row(
                  children: [
                    Text(
                      eformData.level,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(10),
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: (val) => Validation.nonEmptyField(val!),
                        textAlign: TextAlign.start,
                        controller: eformData.controller,
                        decoration: InputDecoration(
                          filled: true,
                          isDense: true,
                          border: UnderlineInputBorder(),
                          labelText: 'Enter value',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class _FormData {
  final TextEditingController controller;
  final Job job;
  final String level;

  _FormData({
    required this.controller,
    required this.job,
    required this.level,
  });
}
