import 'package:erb_mobo/ui/department_center/bloc/department_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/animationAppWidget.dart';
import '../../../common/common_widgets/app_drawer.dart';
import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../common/common_widgets/common_add_FLB.dart';
import '../../../common/common_widgets/common_scaffold_app.dart';
import '../../../common/common_widgets/custom_app_button.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../models/department.dart';
import '../widgets/department_center_page_widgets/create_department.dart';
import '../widgets/department_center_page_widgets/department_card.dart';

class DepartmentCenterPage extends StatefulWidget {
  const DepartmentCenterPage({Key? key}) : super(key: key);

  @override
  State<DepartmentCenterPage> createState() => _DepartmentCenterPageState();
}

class _DepartmentCenterPageState extends State<DepartmentCenterPage> {
  final DepartmentBloc departmentBloc = DepartmentBloc();
  late List<Department> departmentsList = [];
  late bool isLoading = true;
  @override
  void initState() {
    super.initState();
    departmentBloc.add(GetDepartments());
  }

  void listenOnCreattedNewDepartmentAction() {
    departmentBloc.add(GetDepartments());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: departmentBloc,
      listener: (context, state) async {
        if (state is SuccessGettedDepartment) {
          await Future.delayed(
            Duration(seconds: 3),
          );
          setState(() {
            departmentsList = state.department;
            isLoading = false;
          });
        } else if (state is ErrorGettedDepatment) {
          await Future.delayed(
            Duration(seconds: 3),
          );
          setState(() {
            isLoading = false;
          });
        }
      },
      child: CommonScaffoldApp(
        title: 'Departments Center',
        actions: [
          CreateDepatment(
            jobListCallBack: listenOnCreattedNewDepartmentAction,
          ),
        ],
        flb: CreateDepatment(
          jobListCallBack: listenOnCreattedNewDepartmentAction,
          childWidget: CommonAddFLB(
            icon: Icons.add,
          ),
        ),
        child: !isLoading
            ? BlocBuilder(
                bloc: departmentBloc,
                builder: (context, state) {
                  if (state is SuccessGettedDepartment) {
                    return departmentsList.isEmpty
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
                                  CreateDepatment(
                                    jobListCallBack:
                                        listenOnCreattedNewDepartmentAction,
                                    childWidget: CustomAppButton(
                                      title: 'add new one',
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(5),
                              vertical: ScreenUtil().setHeight(10),
                            ),
                            itemCount: departmentsList.length,
                            itemBuilder: (
                              BuildContext context,
                              int index,
                            ) =>
                                DepartmentCard(
                              department: departmentsList[index],
                              index: index,
                            ),
                          );
                  } else if (state is ErrorGettedDepatment) {
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
                            departmentBloc.add(GetDepartments());
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
              )
            : AnimationAppWidget(
                name: AnimationWidgetNames.ProgressIndicator,
              ),
      ),
    );
  }
}
