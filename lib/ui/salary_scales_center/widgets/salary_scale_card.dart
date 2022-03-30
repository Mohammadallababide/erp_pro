import 'package:erb_mobo/core/utils/costant.dart';
import 'package:erb_mobo/ui/salary_scales_center/bloc/salaryscales_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../common/common_widgets/app_snack_bar.dart';
import '../../../common/common_widgets/commonDialog/confirm_process_Dialog.dart';
import '../../../models/salary-scale.dart';

class SalaryScaleCard extends StatefulWidget {
  final SalaryScale salaryScale;
  final int index;
  final Function delettingSalaryScaleCallBack;
  final Function activateScaleSalaryCallBack;
  final bool isActive;
  SalaryScaleCard({
    Key? key,
    required this.index,
    required this.salaryScale,
    required this.delettingSalaryScaleCallBack,
    required this.isActive,
    required this.activateScaleSalaryCallBack,
  }) : super(key: key);

  @override
  State<SalaryScaleCard> createState() => _SalaryScaleCardState();
}

class _SalaryScaleCardState extends State<SalaryScaleCard> {
  late List<ChartData> data = [];
  final SalaryScalesBloc salaryScalesBloc = SalaryScalesBloc();

  @override
  void initState() {
    super.initState();
    widget.salaryScale.salaryScaleJobs.forEach((element) {
      data.add(ChartData(
        jobPostion: '${element.jobId} ' + element.employeeLevel,
        amount: element.amount,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(5),
        vertical: ScreenUtil().setHeight(5),
      ),
      child: Container(
        width: double.infinity,
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                  vertical: ScreenUtil().setHeight(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: ScreenUtil().setHeight(13),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                ScreenUtil().setSp(150),
                              ),
                              child: Center(
                                child: Text(
                                  widget.index.toString(),
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(14),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        Text(
                          'Salary Scale',
                          style: GoogleFonts.yanoneKaffeesatz(
                            fontStyle: FontStyle.normal,
                            textStyle: TextStyle(
                              fontSize: ScreenUtil().setSp(22),
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlocListener(
                      bloc: salaryScalesBloc,
                      listener: (context, state) {
                        if (state is ErrorDelettingSalaryScale) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              getAppSnackBar(
                                  message: 'Faild Deletting Salary Scale !',
                                  context: context));
                        } else if (state is SuccessDelettingSalaryScale) {
                          setState(() {
                            widget.delettingSalaryScaleCallBack(
                                widget.salaryScale.id);
                          });
                        } else if (state is ErrorActivateSalaryScale) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              getAppSnackBar(
                                  message: 'Faild Activate Salary Scale !',
                                  context: context));
                        } else if (state is SuccessAcivateSalaryScale) {
                          setState(() {
                            widget.activateScaleSalaryCallBack(widget.index);
                          });
                        }
                      },
                      child: Row(
                        children: [
                          BlocBuilder(
                            bloc: salaryScalesBloc,
                            builder: (context, state) {
                              if (state is DelettingSalaryScale) {
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
                                    salaryScalesBloc.add(
                                      DeleteSalaryScale(
                                        widget.salaryScale.id,
                                      ),
                                    );
                                  },
                                  prcessedText:
                                      "Are You Sure Want To Delete this Salary Scale ?",
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                icon: Icon(
                                  Icons.delete,
                                ),
                                color: Colors.red,
                                iconSize: ScreenUtil().setSp(25),
                                tooltip: 'delete scale',
                              );
                            },
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(2),
                          ),
                          BlocBuilder(
                            bloc: salaryScalesBloc,
                            builder: (context, state) {
                              if (state is ActivatingSalaryScale) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.green.shade800,
                                    strokeWidth: ScreenUtil().setWidth(3),
                                  ),
                                );
                              }
                              return IconButton(
                                icon: Icon(
                                  Icons.power_settings_new_rounded,
                                ),
                                color: widget.isActive
                                    ? Colors.green.shade800
                                    : Colors.grey,
                                iconSize: ScreenUtil().setSp(25),
                                tooltip: 'Active power',
                                onPressed: () {
                                  salaryScalesBloc.add(
                                    ActivateSalaryScale(widget.salaryScale.id),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SfCartesianChart(
                  palette: <Color>[
                    // Colors.teal,
                    Theme.of(context).primaryColor
                  ],
                  primaryXAxis: CategoryAxis(),
                  series: <ChartSeries>[
                    BarSeries<ChartData, String>(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(ScreenUtil().radius(15)),
                          bottomRight:
                              Radius.circular(ScreenUtil().radius(15))),
                      dataSource: data,
                      xValueMapper: (ChartData data, _) => data.jobPostion,
                      yValueMapper: (ChartData data, _) => data.amount,
                    ),
                    // StackedColumnSeries<ChartData, String>(
                    //     borderRadius: BorderRadius.only(
                    //         topLeft: Radius.circular(ScreenUtil().radius(10)),
                    //         bottomRight:
                    //             Radius.circular(ScreenUtil().radius(10))),
                    //     dataSource: data,
                    //     xValueMapper: (ChartData data, _) => data.jobPostion,
                    //     yValueMapper: (ChartData data, _) => data.amount),
                  ])
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData({
    required this.amount,
    required this.jobPostion,
  });
  final int amount;
  final String jobPostion;
}
