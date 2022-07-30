import 'package:erb_mobo/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/generate_screen.dart';
import '../../../common/theme_helper.dart';
import '../../../core/utils/costant.dart';
import '../bloc/users_bloc.dart';

class UserCard extends StatelessWidget {
  final User user;
  final UsersBloc usersBloc;
  const UserCard({Key? key, required this.user, required this.usersBloc})
      : super(key: key);

  void listenToRefreshDataAction() {
    usersBloc.add(GetUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ScreenUtil().setWidth(5),
        ScreenUtil().setHeight(0),
        ScreenUtil().setWidth(5),
        ScreenUtil().setHeight(0),
      ),
      child: ListTile(
        title: Text(
          user.firstName + ' ' + user.lastName,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(14)),
        ),
        subtitle: Text(user.roles != null ? user.roles![0] : ''),
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
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.settings_rounded,
                  color: Theme.of(context).primaryColor,
                  size: ScreenUtil().setSp(30),
                ),
                onPressed: () => showOptionBottomSheet(
                    context, user.jobId == null ? true : false),
              ),
              user.jobId == null
                  ? Icon(
                      Icons.warning_rounded,
                      color: Color.fromARGB(255, 156, 21, 21),
                      size: ScreenUtil().setSp(17),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );

    //  Padding(
    //   padding: EdgeInsets.fromLTRB(
    //     ScreenUtil().setWidth(10),
    //     ScreenUtil().setHeight(5),
    //     ScreenUtil().setWidth(10),
    //     ScreenUtil().setHeight(5),
    //   ),
    //   child: Material(
    //     elevation: 0.3,
    //     borderRadius: BorderRadius.all(
    //       Radius.circular(
    //         ScreenUtil().radius(15),
    //       ),
    //     ),
    //     child: Container(
    //       padding: EdgeInsets.fromLTRB(
    //         ScreenUtil().setWidth(15),
    //         ScreenUtil().setHeight(3),
    //         ScreenUtil().setWidth(15),
    //         ScreenUtil().setHeight(3),
    //       ),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Row(
    //                 children: [
    //                   Container(
    //                     height: ScreenUtil().setSp(30),
    //                     width: ScreenUtil().setSp(30),
    //                     decoration: BoxDecoration(
    //                         color: Theme.of(context).primaryColor,
    //                         shape: BoxShape.circle,
    //                         image: DecorationImage(
    //                           image: AssetImage(
    //                             'assets/images/useric.png',
    //                           ),
    //                           fit: BoxFit.contain,
    //                         )),
    //                   ),
    //                   SizedBox(
    //                     width: ScreenUtil().setWidth(8),
    //                   ),
    //                   Text(
    //                     user.firstName + ' ' + user.lastName,
    //                     style: TextStyle(
    //                       color: Colors.black,
    //                       fontSize: ScreenUtil().setSp(18),
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               Row(
    //                 children: [
    //                   Icon(
    //                     Icons.check_circle,
    //                     color: Theme.of(context).primaryColor,
    //                     size: ScreenUtil().setSp(21),
    //                   ),
    //                   user.jobId == null
    //                       ? Row(
    //                           children: [
    //                             SizedBox(
    //                               width: ScreenUtil().setWidth(8),
    //                             ),
    //                             Icon(
    //                               Icons.warning_rounded,
    //                               color: Color.fromARGB(255, 105, 83, 5),
    //                               size: ScreenUtil().setSp(22),
    //                             ),
    //                           ],
    //                         )
    //                       : Container(),
    //                 ],
    //               ),
    //             ],
    //           ),
    //           SizedBox(
    //             width: ScreenUtil().setWidth(4),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
    //             child: Text(
    //               user.roles![0],
    //               style: TextStyle(
    //                 color: Colors.grey,
    //                 fontSize: ScreenUtil().setSp(16),
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: ScreenUtil().setHeight(5),
    //           ),
    //           buildAssignOrEditJobButton(
    //               context, user.jobId == null ? true : false),
    //           SizedBox(
    //             height: ScreenUtil().setHeight(10),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  showOptionBottomSheet(BuildContext context, bool isAssignJobAction) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ScreenUtil().radius(40)),
            topRight: Radius.circular(
              ScreenUtil().radius(40),
            ),
          ),
        ),
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              gradient: ConstatValues.secGradientColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ScreenUtil().radius(40)),
                topRight: Radius.circular(
                  ScreenUtil().radius(40),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                ScreenUtil().setSp(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: ScreenUtil().setSp(80),
                        width: ScreenUtil().setSp(80),
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
                        height: ScreenUtil().setHeight(8),
                      ),
                      Text(
                        user.firstName + ' ' + user.lastName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                  Divider(
                    thickness: 2, // thickness of the line
                    indent: ScreenUtil().setSp(30),
                    endIndent: ScreenUtil().setSp(30),
                    color: Colors.grey,
                    height: ScreenUtil().setHeight(25),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.account_box,
                      color: Theme.of(context).secondaryHeaderColor,
                      size: ScreenUtil().setSp(27),
                    ),
                    title: Text(
                      'Show User Profile',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, NameScreen.userProfilePage,
                          arguments: {
                            'id': user.id,
                          });
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.beach_access_rounded,
                      color: Theme.of(context).secondaryHeaderColor,
                      size: ScreenUtil().setSp(27),
                    ),
                    title: Text(
                      'Edit User Leaves',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.business_center,
                      color: Theme.of(context).secondaryHeaderColor,
                      size: ScreenUtil().setSp(27),
                    ),
                    title: Text(
                      !isAssignJobAction ? 'Edit Job' : 'Assign Job',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, NameScreen.assignJobCenterPage,
                          arguments: {
                            'user': user,
                            'jobId': user.jobId,
                            'jobLevel': user.level,
                            'refreshDataCallBack': listenToRefreshDataAction,
                          });
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Align buildAssignOrEditJobButton(
      BuildContext context, bool isAssignJobAction) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, NameScreen.assignJobCenterPage,
              arguments: {
                'user': user,
                'jobId': user.jobId,
                'jobLevel': user.level,
                'refreshDataCallBack': listenToRefreshDataAction,
              });
        },
        child: Container(
          height: ScreenUtil().setHeight(35),
          width: ScreenUtil().setWidth(75),
          decoration: ThemeHelper().buttonBoxDecoration(context: context),
          child: Center(
            child: Text(
              !isAssignJobAction ? 'Edit Job' : 'Assign Job',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
