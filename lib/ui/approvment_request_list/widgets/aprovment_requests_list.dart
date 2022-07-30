import 'package:erb_mobo/core/utils/app_snack_bar.dart';
import 'package:erb_mobo/models/user.dart';
import 'package:erb_mobo/ui/approvment_request_list/widgets/request_approvment_card.dart';
import 'package:erb_mobo/ui/auths/bloc/auths_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/animationAppWidget.dart';
import '../../../common/common_widgets/custom_app_button.dart';

class ApprovmentRequestsList extends StatefulWidget {
  const ApprovmentRequestsList({Key? key}) : super(key: key);

  @override
  State<ApprovmentRequestsList> createState() => _ApprovmentRequestsListState();
}

class _ApprovmentRequestsListState extends State<ApprovmentRequestsList> {
  late bool isLoading = true;

  List<User> usersRequests = [];

  final AuthsBloc authsBloc = AuthsBloc();

  List<User> listenToApprovmentRequests(int userId) {
    setState(() {
      usersRequests.removeWhere((element) => element.id == userId);
    });

    return usersRequests;
  }

  @override
  void initState() {
    authsBloc.add(GetUsersSignupRequests());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: authsBloc,
      listener: (context, state) async {
        if (state is SucessGettingSignupUsersRequests) {
          await Future.delayed(
            Duration(seconds: 3),
          );
          setState(() {
            isLoading = false;
            usersRequests = state.users.reversed.toList();
          });
        } else if (state is ErrorGettingSignupUsersRequests) {
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
              bloc: authsBloc,
              builder: (context, state) {
                if (state is SucessGettingSignupUsersRequests) {
                  return usersRequests.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimationAppWidget(
                              name: AnimationWidgetNames.empty1,
                            ),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            Column(
                              children: [
                                Text(
                                  'There is no registred requests yet!',
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
                              ],
                            )
                          ],
                        )
                      : ListView.builder(
                          itemCount: usersRequests.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                RequestApprovmentCard(
                                  user: usersRequests[index],
                                  usersRequestsCallBack:
                                      listenToApprovmentRequests,
                                ),
                                Divider(
                                  thickness: 2, // thickness of the line
                                  indent: ScreenUtil().setSp(30),
                                  endIndent: ScreenUtil().setSp(30),
                                  color: Colors.teal,
                                  height: ScreenUtil().setHeight(25),
                                )
                              ],
                            );
                          },
                        );
                } else if (state is ErrorGettingSignupUsersRequests) {
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
                          authsBloc.add(GetUsersSignupRequests());
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
              },
            )
          : AnimationAppWidget(
              name: AnimationWidgetNames.ProgressIndicator,
            ),
    );
  }
}
