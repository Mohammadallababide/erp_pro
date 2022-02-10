import 'package:erb_mobo/common/common_widgets/app_snack_bar.dart';
import 'package:erb_mobo/common/theme_helper.dart';
import 'package:erb_mobo/models/user.dart';
import 'package:erb_mobo/ui/auths/bloc/auths_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestApprovmentCard extends StatefulWidget {
  final User user;
  RequestApprovmentCard({required this.user});

  @override
  _RequestApprovmentCardState createState() => _RequestApprovmentCardState();
}

class _RequestApprovmentCardState extends State<RequestApprovmentCard> {
  final AuthsBloc authsBloc = AuthsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: authsBloc,
      listener: (context, state) {
        if(state is ErrorGettingSignupUsersRequests ){
          ScaffoldMessenger.of(context).showSnackBar( getAppSnackBar(message: 'faild Process!!',context:context));
        }
      },
      child: _contentCard(),
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
              Text(
                widget.user.firstName + ' ' + widget.user.lastName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
              _getApprovmentCardState()
            ],
          ),
        ),
      ),
    );
  }

  _getApprovmentCardState() {
    return !(widget.user.isActive)!
        ? BlocBuilder(
            bloc: authsBloc,
            builder: (context, state) {
              if (state is SuccessApproveSignupUser) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20)),
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Colors.blue,
                    size: ScreenUtil().setSp(35),
                  ),
                );
              } else if (state is ProcessingApproveSignupUser) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20)),
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    strokeWidth: ScreenUtil().setWidth(3),
                  ),
                );
              } else {
                return Container(
                  margin: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(7),
                      horizontal: ScreenUtil().setWidth(0)),
                  decoration: ThemeHelper().buttonBoxDecoration(context),
                  child: ElevatedButton(
                      style: ThemeHelper().buttonStyle(),
                      child: Center(
                        child: Text(
                          'Accespt',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      onPressed: () =>
                          authsBloc.add(ApproveSignupUser(widget.user.id))),
                );
              }
            },
          )
        : Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: Icon(
              Icons.check_circle_outline,
              color: Colors.blue,
              size: ScreenUtil().setSp(35),
            ),
          );
  }
}
