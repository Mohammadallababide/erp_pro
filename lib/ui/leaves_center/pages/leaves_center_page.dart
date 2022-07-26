import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/animationAppWidget.dart';
import '../../../common/common_widgets/common_scaffold_app.dart';
import '../../../common/common_widgets/custom_app_button.dart';
import '../../../common/controllers/leaves_controller.dart';
import '../../../common/generate_screen.dart';
import '../../../models/leave.dart';
import '../bloc/leave_center_bloc.dart';
import '../widgets/LeaveCategory/LeavesCategoryCenterWidgets/leave_filter.dart';

class LeavesCenter extends StatefulWidget {
  const LeavesCenter({Key? key}) : super(key: key);

  @override
  State<LeavesCenter> createState() => _LeavesCenterState();
}

class _LeavesCenterState extends State<LeavesCenter> {
  LeaveCenterBloc leaveCenterBloc = LeaveCenterBloc();
  late List<Leave> leaves = [];
  late bool isLoading = true;

  @override
  void initState() {
    super.initState();
    leaveCenterBloc.add(GetLeaves());
    setState(() => {
          isLoading = true,
        });
  }

  void listneToAddNewLeaveAction() {
    setState(() {
      leaveCenterBloc.add(GetLeaves());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: leaveCenterBloc,
      listener: (context, state) async {
        if (state is SuccessGettedLeavesRequests) {
          await Future.delayed(
            Duration(seconds: 3),
          );
          setState(() {
            leaves = state.leaves;
            isLoading = false;
          });
        } else if (state is ErrorGettedLeavesRequests) {
          await Future.delayed(
            Duration(seconds: 3),
          );
          setState(() {
            isLoading = false;
          });
        }
      },
      child: DefaultTabController(
        length: 2,
        child: CommonScaffoldApp(
            title: 'Leaves Center',
            actions: [
              IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: () {
                  Navigator.pushNamed(
                      context, NameScreen.createLeaveRequestPage,
                      arguments: {'actionCallBack': listneToAddNewLeaveAction});
                },
              ),
              IconButton(
                icon: Icon(Icons.category_outlined),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    NameScreen.leavesCategoriesPage,
                  );
                },
              ),
            ],
            flb: buildFloattingctionsButton(),
            bottom: PreferredSize(
              preferredSize: Size(
                0,
                ScreenUtil().setHeight(60),
              ),
              child: const TabBar(
                tabs: [
                  Tab(
                    icon: null,
                    text: 'pending approval',
                    iconMargin: const EdgeInsets.all(0),
                  ),
                  Tab(
                    icon: null,
                    text: 'Archived',
                    iconMargin: const EdgeInsets.all(0),
                  ),
                ],
              ),
            ),
            child: buildPageBody()),
      ),
    );
  }

  Widget buildPageBody() {
    return !isLoading
        ? BlocBuilder(
            bloc: leaveCenterBloc,
            builder: (context, state) {
              if (state is ErrorGettedLeavesRequests) {
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
                        leaveCenterBloc.add(GetLeaves());
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
              } else if (state is SuccessGettedLeavesRequests) {
                LeavesController leavesController =
                    LeavesController(state.leaves);
                return TabBarView(
                  children: [
                    // for pending approval filter
                    LeaveFilter(
                      leaves: leavesController.getPendingApprovalLeaves(),
                    ),
                    // for Archived filter
                    LeaveFilter(
                      leaves: leavesController.getArchivedLeaves(),
                    ),
                  ],
                );
              }
              return Container();
            },
          )
        : AnimationAppWidget(
            name: AnimationWidgetNames.ProgressIndicator,
          );
  }

  Widget buildFloattingctionsButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            heroTag: null,
            child: Center(
              child: Icon(Icons.category_outlined,
                  color: Colors.white, size: ScreenUtil().setSp(25)),
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                NameScreen.leavesCategoriesPage,
              );
            }),
        SizedBox(
          height: ScreenUtil().setHeight(5),
        ),
        FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            heroTag: null,
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: ScreenUtil().setSp(30),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, NameScreen.createLeaveRequestPage,
                  arguments: {'actionCallBack': listneToAddNewLeaveAction});
            }),
      ],
    );
  }
}
