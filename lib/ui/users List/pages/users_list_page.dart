import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/app_snack_bar.dart';
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
              listener: (context, state) async {
                if (state is GettingUsers) {
                  setState(() {
                    isFinishGettingUsers = false;
                  });
                }
                if (state is SuccessGetUsers) {
                  await Future.delayed(
                    Duration(seconds: 3),
                  );
                  setState(() {
                    isFinishGettingUsers = true;
                    users = state.users.reversed.toList();
                  });
                } else if (state is ErrorGetUsers) {
                  ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
                      message: 'Faild Process!!', context: context));
                  await Future.delayed(
                    Duration(seconds: 3),
                  );
                  setState(() {
                    isFinishGettingUsers = true;
                    users = [];
                  });
                }
              },
              child: isFinishGettingUsers
                  ? users.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: ScreenUtil().setHeight(150),
                              width: double.infinity,
                              child: FlareActor(
                                "assets/flare/no_user_found.flr",
                                animation: "not_found",
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(5)),
                            Text(
                              'Not Approvel users yet!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bebasNeue(
                                fontStyle: FontStyle.normal,
                                textStyle: TextStyle(
                                  fontSize: ScreenUtil().setSp(25),
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                // height: 1.5,
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (BuildContext context, int index) {
                            return UserCard(
                              user: users[index],
                              usersBloc: usersBloc,
                            );
                          })
                  : Center(
                      child: Container(
                        height: ScreenUtil().setHeight(130),
                        width: double.infinity,
                        child: FlareActor(
                          "assets/flare/users_loader.flr",
                          animation: "animation",
                          fit: BoxFit.contain,
                        ),
                      ),
                    )),
        ),
      ),
    );
  }
}
