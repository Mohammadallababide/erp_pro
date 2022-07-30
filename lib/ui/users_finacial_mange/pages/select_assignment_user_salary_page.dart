import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../models/user.dart';
import '../../users List/bloc/users_bloc.dart';
import '../../../common/common_widgets/CardTilesWidgets/user_card_tile.dart';

class SelectAssignmentUserSalaryPage extends StatefulWidget {
  final Function salaryUserCallBack;
  final int? userSelectedAssignmentSalaryId;

  const SelectAssignmentUserSalaryPage(
      {Key? key,
      required this.salaryUserCallBack,
      this.userSelectedAssignmentSalaryId})
      : super(key: key);

  @override
  _SelectAssignmentUserSalaryPageState createState() =>
      _SelectAssignmentUserSalaryPageState();
}

class _SelectAssignmentUserSalaryPageState
    extends State<SelectAssignmentUserSalaryPage> {
  late List<User> usersList = [];
  UsersBloc usersBloc = UsersBloc();

  @override
  void initState() {
    super.initState();
    usersBloc.add(GetUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context: context, title: 'System Users List'),
      body: BlocBuilder(
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
                : ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            widget.salaryUserCallBack(usersList[index]);
                          });
                          Navigator.pop(context);
                        },
                        child: widget.userSelectedAssignmentSalaryId == null
                            ? UserTileCard(
                                isSelected: false,
                                user: usersList[index],
                              )
                            : widget.userSelectedAssignmentSalaryId ==
                                    usersList[index].id!
                                ? UserTileCard(
                                    isSelected: true,
                                    user: usersList[index],
                                  )
                                : UserTileCard(
                                    isSelected: false,
                                    user: usersList[index],
                                  ),
                      );
                    },
                    itemCount: usersList.length,
                  );
          } else if (state is GettingUsers) {
            return SizedBox(
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                      strokeWidth: ScreenUtil().setWidth(3),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                ],
              ),
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
    );
  }
}
