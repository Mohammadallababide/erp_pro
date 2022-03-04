import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common_widgets/app_snack_bar.dart';
import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../models/user.dart';
import '../bloc/users_bloc.dart';
import '../widgets/userCard.dart';
import '../../../common/common_widgets/app_drawer.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  late bool isFinishGettingUsers = false;
  late List<User> users = [];
  UsersBloc usersBloc = UsersBloc();
  @override
  initState() {
    usersBloc.add(GetUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: commonAppBar(context: context, title: 'approvment users'),
        drawer: const AppDrawer(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.blueGrey[50],
          child: BlocListener(
            bloc: usersBloc,
            listener: (context, state) {
              if (state is SuccessGetUsers) {
                setState(() {
                  isFinishGettingUsers = true;
                  users = state.users.reversed.toList();
                });
              } else if (state is ErrorGetUsers) {
                ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
                    message: 'Faild Process!!', context: context));
                setState(() {
                  isFinishGettingUsers = true;
                  users = [];
                });
              }
            },
            child: isFinishGettingUsers
                ? users.isEmpty
                    ? Center(
                        child: Text(
                          'not approvment requests yet!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(15),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (BuildContext context, int index) {
                          return UserCard(
                            user: users[index],
                          );
                        })
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
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
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
