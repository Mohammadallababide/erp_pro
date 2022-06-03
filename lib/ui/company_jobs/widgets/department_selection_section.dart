import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/theme_helper.dart';
import '../../../models/department.dart';
import '../../department_center/bloc/department_bloc.dart';

class DeprtmentSelectionSection extends StatefulWidget {
  final Function departmentSelectedCallBack;
  final Widget? inkWellChildWidget;
  const DeprtmentSelectionSection({
    this.inkWellChildWidget,
    required this.departmentSelectedCallBack,
    Key? key,
  }) : super(key: key);

  @override
  State<DeprtmentSelectionSection> createState() =>
      _DeprtmentSelectionSectionState();
}

class _DeprtmentSelectionSectionState extends State<DeprtmentSelectionSection> {
  final DepartmentBloc departmentBloc = DepartmentBloc();
  late String departmentName = '';
  @override
  Widget build(BuildContext context) {
    return widget.inkWellChildWidget != null
        ? InkWell(
            child: widget.inkWellChildWidget!,
            onTap: () {
              departmentBloc.add(GetDepartments());
              showDepartmentsListDialog();
            },
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select department : ',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(17),
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(12),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(5),
                    ),
                    child: Text(
                      departmentName.isNotEmpty
                          ? departmentName
                          : 'not selected yet. ',
                      style: TextStyle(
                        shadows: [
                          Shadow(color: Colors.black, offset: Offset(0, -5))
                        ],
                        fontSize: ScreenUtil().setSp(16),
                        color: Colors.transparent,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dashed,
                        decorationColor: Theme.of(context).primaryColor,
                        decorationThickness: 3,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      departmentBloc.add(GetDepartments());
                      showDepartmentsListDialog();
                    },
                    child: Container(
                      height: ScreenUtil().setHeight(30),
                      width: ScreenUtil().setWidth(80),
                      decoration:
                          ThemeHelper().buttonBoxDecoration(context: context),
                      child: Center(
                        child: Text(
                          'change',
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
                  ),
                ],
              ),
            ],
          );
  }

  Future<void> showDepartmentsListDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            width: ScreenUtil().setWidth(260),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(15),
                        vertical: ScreenUtil().setHeight(15)),
                    child: Text(
                      "Departments List",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(20)),
                    ),
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(250),
                  child: BlocBuilder(
                    bloc: departmentBloc,
                    builder: (context, state) {
                      if (state is SuccessGettedDepartment) {
                        return Container(
                          padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(10),
                            right: ScreenUtil().setWidth(10),
                            bottom: ScreenUtil().setHeight(15),
                          ),
                          child: ListView.builder(
                            itemCount: state.department.length,
                            itemBuilder: (BuildContext context, int index) =>
                                departmentListTile(state.department[index]),
                          ),
                        );
                      } else if (state is ErrorGettedDepatment) {
                        return Center(
                          child: Text('some thing is wrong'),
                        );
                      } else if (state is GettingDepartments) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget departmentListTile(Department item) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(8),
      ),
      child: ListTile(
        onTap: () {
          setState(() {
            departmentName = item.title;
            widget.departmentSelectedCallBack(item.id);
          });
          Navigator.pop(context);
        },
        selected: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        selectedTileColor: Theme.of(context).primaryColor,
        title: Text(
          item.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(18),
          ),
        ),
        // subtitle: Text(job.description),
        leading: Icon(
          Icons.account_tree_outlined,
          color: Colors.white,
          size: ScreenUtil().setSp(30),
        ),
        trailing: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: ScreenUtil().setSp(16),
        ),
      ),
    );
  }
}
