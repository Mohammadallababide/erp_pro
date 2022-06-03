import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/theme_helper.dart';
import '../../../../../models/user.dart';
import '../../../../users List/bloc/users_bloc.dart';
import '../../../../users_finacial_mange/widgets/UsersListForAsignmentSalary/user_card_tile.dart';

class UsersListDialogForDepartmentInfo extends StatelessWidget {
  // [users] just for now ....
  final List<User> users;
  UsersListDialogForDepartmentInfo({Key? key, required this.users})
      : super(key: key);
  final UsersBloc usersBloc = UsersBloc();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(50),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
        child: Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () {
              usersBloc.add(GetUsers());
              showAssignOrUnAssignInvoiceOptionDialog(context);
            },
            child: Container(
              height: ScreenUtil().setHeight(35),
              width: ScreenUtil().setWidth(75),
              decoration: ThemeHelper().buttonBoxDecoration(context: context),
              child: Center(
                child: Text(
                  'show List',
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
        ),
      ),
    );
  }

  Future<void> showAssignOrUnAssignInvoiceOptionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(5),
                  vertical: ScreenUtil().setHeight(15)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(15),
                      ),
                      child: Text(
                        "Spuervisers User List",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(18)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  Container(
                    height: ScreenUtil().setHeight(200),
                    child: BlocBuilder(
                      buildWhen: (previous, current) =>
                          previous != current && current is SuccessGetUsers,
                      bloc: usersBloc,
                      builder: (context, state) {
                        if (state is GettingUsers) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        } else if (state is SuccessGetUsers) {
                          return ListView.builder(
                            // itemCount: state.users.length,
                            itemCount: users.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (users.length == 0) {
                                return Center(
                                    child: Text(
                                        'there is not approvment users yet ...'));
                              } else {
                                return UserTileCard(
                                  isSelected: true,
                                  user: users[index],
                                );
                              }
                            },
                          );
                        } else {
                          return Center(
                            child: Text('some thing wrong ...'),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
