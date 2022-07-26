import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/theme_helper.dart';
import '../../../bloc/leave_center_bloc.dart';
import 'leave_category_listTile.dart';

class LeaveCategorySelector extends StatefulWidget {
  final Function selectCategoryActionCallBack;
  final int? preSelectValue;
  const LeaveCategorySelector({
    Key? key,
    required this.selectCategoryActionCallBack,
    this.preSelectValue,
  }) : super(key: key);

  @override
  State<LeaveCategorySelector> createState() => _LeaveCategorySelectorState();
}

class _LeaveCategorySelectorState extends State<LeaveCategorySelector> {
  LeaveCenterBloc leaveCenterBloc = LeaveCenterBloc();
  late String? selectedLeaveCategoryName = null;
  @override
  Widget build(BuildContext context) {
    return selectLeaveCategorySection();
  }

  Widget selectLeaveCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Leave Category Is :',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: ScreenUtil().setSp(16),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedLeaveCategoryName ?? 'Not Selected Yet!',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.w400,
                color: Theme.of(context).primaryColor,
              ),
            ),
            InkWell(
              onTap: () {
                leaveCenterBloc.add(GetLeavesCategories());
                showLeavesCategoryOptionDialog();
              },
              child: Container(
                height: ScreenUtil().setHeight(40),
                width: ScreenUtil().setWidth(75),
                decoration: ThemeHelper().buttonBoxDecoration(context: context),
                child: Center(
                  child: Text(
                    'Select',
                    style: GoogleFonts.belleza(
                      fontStyle: FontStyle.normal,
                      textStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Future<void> showLeavesCategoryOptionDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(5),
                  vertical: ScreenUtil().setHeight(15)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(15),
                      ),
                      child: Text(
                        "Select The Category : ",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(20)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  Container(
                      height: ScreenUtil().setHeight(200),
                      child: BlocBuilder(
                        bloc: leaveCenterBloc,
                        builder: (BuildContext context, state) {
                          if (state is GettingLeavesCategories) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            );
                          } else if (state is SuccessGettedCategories) {
                            return ListView.builder(
                              itemCount: state.leaveCategories.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      widget.selectCategoryActionCallBack(
                                          state.leaveCategories[index].id);
                                      selectedLeaveCategoryName =
                                          state.leaveCategories[index].name;
                                    });
                                  },
                                  child: LeaveCategoryListTile(
                                    item: state.leaveCategories[index],
                                    isSelected: widget.preSelectValue != null &&
                                            state.leaveCategories[index].id ==
                                                widget.preSelectValue
                                        ? true
                                        : false,
                                  ),
                                );
                              },
                            );
                          } else if (state is ErrorGettedCategories) {
                            return Center(child: Text('some thing wrong ...'));
                          }
                          return Container();
                        },
                      )),
                ],
              ),
            ),
          );
        });
  }
}
