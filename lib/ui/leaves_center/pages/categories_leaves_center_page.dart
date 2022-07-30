import 'package:erb_mobo/ui/leaves_center/widgets/LeaveCategory/CreateLeaveCategoryWidgets/create_leave_category_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/animationAppWidget.dart';
import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../common/common_widgets/common_scaffold_app.dart';
import '../../../common/common_widgets/custom_app_button.dart';
import '../../../models/leaveCategory.dart';
import '../bloc/leave_center_bloc.dart';
import '../widgets/LeaveCategory/LeavesCategoryCenterWidgets/leave_category_card.dart';

class CategoriesLeavesCenterPage extends StatefulWidget {
  CategoriesLeavesCenterPage({Key? key}) : super(key: key);

  @override
  State<CategoriesLeavesCenterPage> createState() =>
      _CategoriesLeavesCenterPageState();
}

class _CategoriesLeavesCenterPageState
    extends State<CategoriesLeavesCenterPage> {
  final LeaveCenterBloc leaveCenterBloc = LeaveCenterBloc();
  late List<LeaveCategory> leavesCategories = [];
  late bool isLoading = true;
  @override
  void initState() {
    super.initState();
    leaveCenterBloc.add(GetLeavesCategories());
    setState(() => {
          isLoading = true,
        });
  }

  void listenOnCreattedNewLeaveCategeryAction() {
    leaveCenterBloc.add(GetLeavesCategories());
  }

  void listenOnDeleteCategeryAction(int index) {
    setState(() {
      leavesCategories.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: leaveCenterBloc,
      listener: (context, state) async {
        if (state is SuccessGettedCategories) {
          await Future.delayed(
            Duration(seconds: 3),
          );
          setState(() {
            leavesCategories = state.leaveCategories;
            isLoading = false;
          });
        } else if (state is ErrorGettedCategories) {
          await Future.delayed(
            Duration(seconds: 3),
          );
          setState(() {
            isLoading = false;
          });
        }
      },
      child: CommonScaffoldApp(
        isBakedNav: true,
        isDrawer: false,
        title: 'Leaves Categories Center',
        actions: [
          CreateLeaveCategoryDialog(
            ActionCallBack: listenOnCreattedNewLeaveCategeryAction,
            isInAppBar: true,
          ),
        ],
        flb: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CreateLeaveCategoryDialog(
                ActionCallBack: listenOnCreattedNewLeaveCategeryAction),
          ],
        ),
        child: !isLoading
            ? BlocBuilder(
                bloc: leaveCenterBloc,
                builder: (context, state) {
                  if (state is ErrorGettedCategories) {
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
                            leaveCenterBloc.add(GetLeavesCategories());
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
                  } else if (state is SuccessGettedCategories) {
                    return ListView.builder(
                      itemCount: leavesCategories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return LeaveCategoryCard(
                          leaveCategory: leavesCategories[index],
                          deletingActionCallBack: listenOnDeleteCategeryAction,
                          index: index,
                        );
                      },
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
