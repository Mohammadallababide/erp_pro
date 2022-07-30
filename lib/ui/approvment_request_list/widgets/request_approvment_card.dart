import 'package:erb_mobo/core/utils/app_snack_bar.dart';
import 'package:erb_mobo/models/user.dart';
import 'package:erb_mobo/ui/auths/bloc/auths_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/generate_screen.dart';
import '../../../common/theme_helper.dart';
import '../../../core/utils/app_flash_bar.dart';
import '../../assign_commpany_job/page/assign_job_center_page.dart';
import '../../company_jobs/widgets/department_selection_section.dart';

class RequestApprovmentCard extends StatefulWidget {
  final User user;
  final Function usersRequestsCallBack;
  const RequestApprovmentCard({
    required this.user,
    required this.usersRequestsCallBack,
  });

  @override
  _RequestApprovmentCardState createState() => _RequestApprovmentCardState();
}

class _RequestApprovmentCardState extends State<RequestApprovmentCard> {
  final AuthsBloc authsBloc = AuthsBloc();
  late bool isActiveUser;
  late TextEditingController selectedDepartmentIdController;

  @override
  void initState() {
    isActiveUser = widget.user.isActive ?? false;
    selectedDepartmentIdController = TextEditingController();
    super.initState();
  }

  listeanOnChangedSelectedDepartmentAction(int newValue) {
    setState(() {
      selectedDepartmentIdController.text = newValue.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: authsBloc,
      listener: (context, state) {
        if (state is ErrorGettingSignupUsersRequests ||
            state is ErrorApproveSignupUser ||
            state is ErrorRejectSignupUser) {
          getFlashBar(
            isErrorgMeg: true,
            context: context,
            title: 'Mission Faild',
            message: 'There some thing is wrong',
          );
        } else if (state is SuccessRejectSignupUser) {
          setState(() {
            widget.usersRequestsCallBack(state.user.id);
          });
          getFlashBar(
            context: context,
            title: 'Mission Success',
            message: 'User rejected with success',
          );
        } else if (state is SuccessApproveSignupUser) {
          setState(() {
            widget.usersRequestsCallBack(state.user.id);
          });
          getFlashBar(
            context: context,
            title: 'Mission Success',
            message: 'User approve with success',
          );
          Navigator.pushNamed(context, NameScreen.assignJobCenterPage,
              arguments: {
                'user': widget.user,
              });
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(5),
          ScreenUtil().setHeight(0),
          ScreenUtil().setWidth(5),
          ScreenUtil().setHeight(0),
        ),
        child: ListTile(
          title: Text(
            widget.user.firstName + ' ' + widget.user.lastName,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(14)),
          ),
          subtitle:
              Text(widget.user.roles != null ? widget.user.roles![0] : ''),
          leading: Container(
            height: ScreenUtil().setSp(35),
            width: ScreenUtil().setSp(35),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/useric.png',
                  ),
                  fit: BoxFit.contain,
                )),
          ),
          trailing: SizedBox(
              width: ScreenUtil().setWidth(80),
              child: _getApprovmentCardState()),
        ),
      ),
    );
  }

  _contentCard() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ScreenUtil().setWidth(10),
        ScreenUtil().setHeight(5),
        ScreenUtil().setWidth(10),
        ScreenUtil().setHeight(5),
      ),
      child: Material(
        elevation: 0.3,
        borderRadius: BorderRadius.all(
          Radius.circular(
            ScreenUtil().radius(15),
          ),
        ),
        child: Container(
          height: ScreenUtil().setHeight(50),
          padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(15),
            ScreenUtil().setHeight(3),
            ScreenUtil().setWidth(15),
            ScreenUtil().setHeight(3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: ScreenUtil().setSp(30),
                    width: ScreenUtil().setSp(30),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/useric.png',
                          ),
                          fit: BoxFit.contain,
                        )),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(8),
                  ),
                  Text(
                    widget.user.firstName + ' ' + widget.user.lastName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _getApprovmentCardState()
            ],
          ),
        ),
      ),
    );
  }

  _getApprovmentCardState() {
    return BlocBuilder(
      bloc: authsBloc,
      builder: (context, state) {
        if (state is ProcessingApproveSignupUser ||
            state is ProcessingRejectSignupUser) {
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
              strokeWidth: ScreenUtil().setWidth(3),
            ),
          );
        } else {
          return Row(
            children: [
              InkWell(
                  onTap: () => authsBloc.add(RejectSignupUser(widget.user.id!)),
                  child: Icon(
                    Icons.close,
                    color: Colors.red,
                    size: ScreenUtil().setSp(28),
                  )),
              SizedBox(
                width: ScreenUtil().setWidth(15),
              ),
              InkWell(
                  onTap: () {
                    showNextStepFroAprroveUserDialog();
                  },
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                    size: ScreenUtil().setSp(28),
                  )),
            ],
          );
        }
      },
    );
  }

  Future<void> showNextStepFroAprroveUserDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
                vertical: ScreenUtil().setHeight(20)),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Approve User",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(22)),
                        ),
                        Icon(
                          Icons.person_add_alt,
                          color: Theme.of(context).primaryColor,
                          size: ScreenUtil().setSp(30),
                        ),
                      ],
                    ),
                  ),
                  DeprtmentSelectionSection(
                    departmentSelectedCallBack:
                        listeanOnChangedSelectedDepartmentAction,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Container(
                    decoration:
                        ThemeHelper().buttonBoxDecoration(context: context),
                    child: ElevatedButton(
                        style: ThemeHelper().buttonStyle(),
                        child: Center(
                          child: Text(
                            'Approve'.toUpperCase(),
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
                        onPressed: () {
                          if (selectedDepartmentIdController.text.isNotEmpty) {
                            authsBloc.add(ApproveSignupUser(
                              id: widget.user.id!,
                              departmentId: int.parse(
                                  selectedDepartmentIdController.text),
                            ));
                            Navigator.pop(context);
                          } else {
                            getFlashBar(
                              isWarningMeg: true,
                              context: context,
                              title: 'Warning Msg',
                              message:
                                  'The information requested is incomplete',
                            );
                          }
                        }),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
