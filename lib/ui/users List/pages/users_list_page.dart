import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/animationAppWidget.dart';
import '../../../common/common_widgets/custom_app_button.dart';
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
  late bool isLoading = true;
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
                if (state is SuccessGetUsers) {
                  await Future.delayed(
                    Duration(seconds: 3),
                  );
                  setState(() {
                    isLoading = false;
                    users = state.users.reversed.toList();
                  });
                } else if (state is ErrorGetUsers) {
                  await Future.delayed(
                    Duration(seconds: 3),
                  );
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: !isLoading
                  ? BlocBuilder(
                      bloc: usersBloc,
                      builder: (context, state) {
                        if (state is SuccessGetUsers) {
                          return users.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnimationAppWidget(
                                      name: AnimationWidgetNames.empty1,
                                    ),
                                    SizedBox(
                                        height: ScreenUtil().setHeight(20)),
                                    Column(
                                      children: [
                                        Text(
                                          'Not Approvel users yet!',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.bebasNeue(
                                            fontStyle: FontStyle.normal,
                                            textStyle: TextStyle(
                                              fontSize: ScreenUtil().setSp(25),
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              : ListView.builder(
                                  itemCount: users.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return UserCard(
                                      user: users[index],
                                      usersBloc: usersBloc,
                                    );
                                  });
                        } else if (state is ErrorGetUsers) {
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
                                  usersBloc.add(GetUsers());
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
