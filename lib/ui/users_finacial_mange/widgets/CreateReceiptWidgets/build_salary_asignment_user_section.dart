import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/theme_helper.dart';
import '../../../../models/user.dart';
import '../../../users List/bloc/users_bloc.dart';
import '../UsersListForAsignmentSalary/user_card_tile.dart';

class SalaryAsignmentUserSection extends StatefulWidget {
  const SalaryAsignmentUserSection({
    Key? key,
    required this.salaryUserIdCallBack,
  }) : super(key: key);
  final Function salaryUserIdCallBack;

  @override
  _SalaryAsignmentUserSectionState createState() =>
      _SalaryAsignmentUserSectionState();
}

class _SalaryAsignmentUserSectionState
    extends State<SalaryAsignmentUserSection> {
  UsersBloc usersBloc = UsersBloc();
  late List<User> usersList = [];
  @override
  void initState() {
    usersBloc.add(GetUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Salary Asignment To :',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.w700,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(15),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: ScreenUtil().setSp(25),
                    width: ScreenUtil().setSp(25),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Image(
                      image: AssetImage('assets/images/useric.png'),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(7),
                  ),
                  Text(
                    "Mohammad Al lababidi",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              InkWell(
                onTap: () => _showUsersListForAsignment(),
                child: Container(
                  height: ScreenUtil().setHeight(40),
                  width: ScreenUtil().setWidth(75),
                  decoration:
                      ThemeHelper().buttonBoxDecoration(context: context),
                  child: Center(
                    child: Text(
                      'Change',
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
        ),
      ],
    );
  }

  Future<void> _showUsersListForAsignment() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SizedBox(
              height: ScreenUtil().setHeight(350),
              child: BlocBuilder(
                bloc: usersBloc,
                builder: (context, state) {
                  if (state is SuccessGetUsers) {
                    usersList = state.users;
                    return usersList.isEmpty
                        ? Center(
                            child: Text(
                              'There is no users',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: ScreenUtil().setSp(15)),
                            ),
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(10),
                                  top: ScreenUtil().setHeight(10),
                                ),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Salary Asignment To :",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: ScreenUtil().setSp(20)),
                                  ),
                                ),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(15)),
                              Expanded(
                                child: ListView(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget.salaryUserIdCallBack(1);
                                        });
                                        Navigator.pop(context);
                                      },
                                      child:
                                          const UserTileCard(isSelected: false),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget.salaryUserIdCallBack(1);
                                        });
                                        Navigator.pop(context);
                                      },
                                      child:
                                          const UserTileCard(isSelected: true),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget.salaryUserIdCallBack(1);
                                        });
                                        Navigator.pop(context);
                                      },
                                      child:
                                          const UserTileCard(isSelected: false),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                  } else if (state is GettingUsers) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                          strokeWidth: ScreenUtil().setWidth(3),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(15),
                        ),
                      ],
                    );
                  } else if (state is ErrorGetUsers) {
                    return Center(
                      child: Text(
                        'some thing is wrong',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: ScreenUtil().setSp(15)),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          );
        });
  }
}
