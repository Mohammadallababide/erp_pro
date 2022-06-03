import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../models/salary-scale-job.dart';
import '../../../models/salary-scale.dart';

class ScaleSalaryDetailsPage extends StatefulWidget {
  final SalaryScale salaryScale;

  const ScaleSalaryDetailsPage({Key? key, required this.salaryScale})
      : super(key: key);

  @override
  State<ScaleSalaryDetailsPage> createState() => _ScaleSalaryDetailsPageState();
}

class _ScaleSalaryDetailsPageState extends State<ScaleSalaryDetailsPage> {
  List<SalaryScaleForSpcificJob> salaryScaleForSpcificJobList = [];

  @override
  void initState() {
    for (int i = 0; i <= widget.salaryScale.salaryScaleJobs.length - 2; i += 3) {
      salaryScaleForSpcificJobList.add(
        SalaryScaleForSpcificJob(
          jonior: widget.salaryScale.salaryScaleJobs[i + 2],
          midLevel: widget.salaryScale.salaryScaleJobs[i + 1],
          senior: widget.salaryScale.salaryScaleJobs[i],
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        title: 'Salary Scale Details',
        context: context,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(2),
          vertical: ScreenUtil().setHeight(10),
        ),
        child: ListView.builder(
            itemCount: salaryScaleForSpcificJobList.length,
            itemBuilder: (BuildContext context, int index) =>
                buildSalaryScaleJobCard(
                    salaryScaleJobsForJunior:
                        salaryScaleForSpcificJobList[index].jonior,
                    salaryScaleJobsForMidLevel:
                        salaryScaleForSpcificJobList[index].midLevel,
                    salaryScaleJobsForSenior:
                        salaryScaleForSpcificJobList[index].senior,
                    context: context)),
      ),
    );
  }

  Widget buildSalaryScaleJobCard({
    required SalaryScaleJob salaryScaleJobsForJunior,
    required SalaryScaleJob salaryScaleJobsForMidLevel,
    required SalaryScaleJob salaryScaleJobsForSenior,
    required BuildContext context,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtil().radius(25)),
      ),
      elevation: 2.5,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(15),
              vertical: ScreenUtil().setHeight(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  salaryScaleJobsForJunior.job!.name.toUpperCase(),
                  style: GoogleFonts.cairo(
                    fontStyle: FontStyle.normal,
                    textStyle: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.work,
                  size: ScreenUtil().setSp(22),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
          buildJobSalaryScaleLevelSection(salaryScaleJobsForJunior),
          buildJobSalaryScaleLevelSection(salaryScaleJobsForMidLevel),
          buildJobSalaryScaleLevelSection(salaryScaleJobsForSenior),
          SizedBox(
            height: ScreenUtil().setHeight(15),
          ),
        ],
      ),
    );
  }

  Row buildJobSalaryScaleLevelSection(SalaryScaleJob salaryScaleJob) {
    return Row(
      children: [
        Expanded(
          child: buildTextInfoField(
            lebel: 'job postion level',
            fieldValue: salaryScaleJob.employeeLevel,
            prefixIcon: Icons.switch_account_outlined,
          ),
        ),
        SizedBox(
          height: ScreenUtil().setWidth(5),
        ),
        Expanded(
          child: buildTextInfoField(
            lebel: 'salary amount',
            fieldValue: salaryScaleJob.amount.toString(),
            prefixIcon: Icons.monetization_on_rounded,
          ),
        ),
      ],
    );
  }

  Widget buildTextInfoField({
    required String lebel,
    required String fieldValue,
    required IconData prefixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: true,
        initialValue: fieldValue,
        decoration: InputDecoration(
          labelText: lebel,
          labelStyle: TextStyle(
            fontSize: ScreenUtil().setSp(15),
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().radius(25))),
            borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).primaryColor,
            ),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

class SalaryScaleForSpcificJob {
  final SalaryScaleJob senior;
  final SalaryScaleJob midLevel;
  final SalaryScaleJob jonior;

  SalaryScaleForSpcificJob(
      {required this.senior, required this.midLevel, required this.jonior});
}
