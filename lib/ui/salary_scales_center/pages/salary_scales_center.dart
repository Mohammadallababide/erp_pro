import 'package:erb_mobo/ui/salary_scales_center/bloc/salaryscales_bloc.dart';
import 'package:erb_mobo/ui/salary_scales_center/widgets/salary_scale_card.dart';
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
import '../../../core/utils/app_snack_bar.dart';
import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../models/salary-scale.dart';
import 'create_new_salary_scale_page.dart';

class SalaryScalesCenter extends StatefulWidget {
  SalaryScalesCenter({Key? key}) : super(key: key);

  @override
  State<SalaryScalesCenter> createState() => _SalaryScalesCenterState();
}

class _SalaryScalesCenterState extends State<SalaryScalesCenter> {
  final SalaryScalesBloc salaryScalesBloc = SalaryScalesBloc();
  late List<SalaryScale> salaryScaleList = [];
  late int activateSalaryScaleIndex = 0;
  late bool isLoading = true;
  @override
  void initState() {
    super.initState();
    salaryScalesBloc.add(GetCompanySalaryScales());
  }

  listenDelettingSalaryScale(int index) {
    setState(() {
      salaryScaleList.removeAt(index);
    });
  }

  listenActivategSalaryScale(int index) {
    setState(() {
      activateSalaryScaleIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: salaryScalesBloc,
      listener: (context, state) async {
        if (state is ErrorGettingSalaryScales) {
          await Future.delayed(
            Duration(seconds: 3),
          );
          setState(() {
            isLoading = false;
          });
        } else if (state is SuccessGettingSalaryScales) {
          await Future.delayed(
            Duration(seconds: 3),
          );

          setState(() {
            salaryScaleList = state.salaryScales;
            activateSalaryScaleIndex =
                salaryScaleList.indexWhere((element) => element.isActive);
            isLoading = false;
          });
        }
      },
      child: CommonScaffoldApp(
        title: 'salary scales',
        actions: [
          IconButton(
            onPressed: () async {
              final bool? shouldRefresh = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateNewSalaryScalePage(),
                ),
              );
              if (shouldRefresh != null) {
                if (shouldRefresh) {
                  salaryScalesBloc.add(GetCompanySalaryScales());
                }
              }
            },
            icon: Icon(
              Icons.add_circle,
              size: ScreenUtil().setSp(28),
            ),
          ),
        ],
        flb: CommonAddFLB(
          icon: Icons.add,
          func: () async {
            final bool? shouldRefresh = await Navigator.push<bool>(
              context,
              MaterialPageRoute(
                builder: (context) => CreateNewSalaryScalePage(),
              ),
            );
            if (shouldRefresh != null) {
              if (shouldRefresh) {
                salaryScalesBloc.add(GetCompanySalaryScales());
              }
            }
          },
        ),
        child: isLoading
            ? AnimationAppWidget(
                name: AnimationWidgetNames.ProgressIndicator,
              )
            : BlocBuilder(
                bloc: salaryScalesBloc,
                builder: (context, state) {
                  if (state is SuccessGettingSalaryScales) {
                    return salaryScaleList.isEmpty
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
                                    'There is no departments created yet!',
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
                                    onTap: () async {
                                      final bool? shouldRefresh =
                                          await Navigator.push<bool>(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CreateNewSalaryScalePage(),
                                        ),
                                      );
                                      if (shouldRefresh != null) {
                                        if (shouldRefresh) {
                                          salaryScalesBloc
                                              .add(GetCompanySalaryScales());
                                        }
                                      }
                                    },
                                    child: CustomAppButton(
                                      title: 'add new one',
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        : ListView.builder(
                            itemCount: salaryScaleList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SalaryScaleCard(
                                salaryScale: salaryScaleList[index],
                                isActive: activateSalaryScaleIndex == index,
                                index: index,
                                delettingSalaryScaleCallBack:
                                    listenDelettingSalaryScale,
                                activateScaleSalaryCallBack:
                                    listenActivategSalaryScale,
                              );
                            },
                          );
                  } else if (state is ErrorGettingSalaryScales) {
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
                            salaryScalesBloc.add(GetCompanySalaryScales());
                            setState(() => {
                                  isLoading = true,
                                });
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
