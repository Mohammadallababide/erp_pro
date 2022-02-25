import 'package:erb_mobo/common/common_widgets/app_snack_bar.dart';
import 'package:erb_mobo/common/common_widgets/pick_image_widget.dart';
import 'package:erb_mobo/ui/auths/bloc/auths_bloc.dart';
import 'package:erb_mobo/ui/my_profile/bloc/myprofilebloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserPersonalInfo extends StatelessWidget {
  final MyprofileblocBloc myprofileblocBloc;
  final AuthsBloc authsBloc = AuthsBloc();
  UserPersonalInfo({Key? key, required this.myprofileblocBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: myprofileblocBloc,
      listener: (context, state) {
        if (state is ErrorFetchMyProfileInfo) {
          ScaffoldMessenger.of(context).showSnackBar(
              getAppSnackBar(message: 'Faild Process!!', context: context));
        }
      },
      child: BlocBuilder(
        bloc: myprofileblocBloc,
        builder: (context, state) {
          if (state is SuccessFetchMyProfileInfo) {
            return ListView(
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: PickImageWidget(
                    authsBloc: authsBloc,
                    cirSize: 150,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(25),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.user.roles[0],
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(20),
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(5),
                        ),
                        Icon(
                          Icons.check_circle_outline_sharp,
                          size: ScreenUtil().setSp(20),
                          color: Colors.blueAccent,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(25),
                    ),
                    buildUserInfoDisplay(
                        state.user.firstName + ' ' + state.user.lastName,
                        'Name',
                        Container(),
                        context),
                    buildUserInfoDisplay(
                        state.user.phoneNumber ?? 'user have not phone num',
                        'Phone',
                        Container(),
                        context),
                    buildUserInfoDisplay(
                        state.user.email, 'Email', Container(), context),
                  ],
                ),
              ],
            );
          } else if (state is ErrorFetchMyProfileInfo) {
            return const Center(
              child: Text('some thing is wrong'),
            );
          } else if (state is FetchingMyProfileInfo) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage,
          BuildContext context) =>
      Padding(
          padding: EdgeInsets.only(
            bottom: ScreenUtil().setHeight(25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(13.5),
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                  width: MediaQuery.of(context).size.width -
                      ScreenUtil().setWidth(30),
                  height: ScreenUtil().setHeight(38),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              // navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(15),
                                height: ScreenUtil().setHeight(1.5),
                              ),
                            ))),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Theme.of(context).primaryColor,
                      size: ScreenUtil().setSp(37),
                    )
                  ]))
            ],
          ));

  // // Widget builds the About Me Section
  // Widget buildAbout() => Padding(
  //     padding: EdgeInsets.only(bottom: 10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text(
  //           'Tell Us About Yourself',
  //           style: TextStyle(
  //             fontSize: 15,
  //             fontWeight: FontWeight.w500,
  //             color: Colors.grey,
  //           ),
  //         ),
  //         const SizedBox(height: 1),
  //         Container(
  //             width: 350,
  //             height: 200,
  //             decoration: const BoxDecoration(
  //                 border: Border(
  //                     bottom: BorderSide(
  //               color: Colors.grey,
  //               width: 1,
  //             ))),
  //             child: Row(children: [
  //               Expanded(
  //                   child: TextButton(
  //                       onPressed: () {
  //                         // navigateSecondPage(Container());
  //                       },
  //                       child: const Padding(
  //                           padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
  //                           child: Align(
  //                               alignment: Alignment.topLeft,
  //                               child: Text(
  //                                 'any description',
  //                                 style: TextStyle(
  //                                   fontSize: 16,
  //                                   height: 1.4,
  //                                 ),
  //                               ))))),
  //               const Icon(
  //                 Icons.keyboard_arrow_right,
  //                 color: Colors.grey,
  //                 size: 40.0,
  //               )
  //             ]))
  //       ],
  //     ));

  // Refrshes the Page after updating user info.
  // FutureOr onGoBack(dynamic value) {
  //   setState(() {});
  // }

  // Handles navigation and prompts refresh.
  // void navigateSecondPage(Widget editForm) {
  //   Route route = MaterialPageRoute(builder: (context) => editForm);
  //   Navigator.push(context, route).then(onGoBack);
  // }
}
