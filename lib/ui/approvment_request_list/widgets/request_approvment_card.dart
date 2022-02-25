import 'package:erb_mobo/common/common_widgets/app_snack_bar.dart';
import 'package:erb_mobo/models/user.dart';
import 'package:erb_mobo/ui/auths/bloc/auths_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestApprovmentCard extends StatefulWidget {
  final User user;
  final Function usersRequestsCallBack;
  const RequestApprovmentCard({
    required this.user,
    required this.usersRequestsCallBack,
  });

  @override
  _RequestApprovmentCardState createState() => _RequestApprovmentCardState();
}

class _RequestApprovmentCardState extends State<RequestApprovmentCard> {
  final AuthsBloc authsBloc = AuthsBloc();
  late bool isActiveUser;

  @override
  void initState() {
    // TODO: implement initState
    isActiveUser = widget.user.isActive ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: authsBloc,
      listener: (context, state) {
        if (state is ErrorGettingSignupUsersRequests ||
            state is ErrorApproveSignupUser ||
            state is ErrorRejectSignupUser) {
          ScaffoldMessenger.of(context).showSnackBar(
              getAppSnackBar(message: 'faild Process!!', context: context));
        } else if (state is SuccessRejectSignupUser) {
          setState(() {
            widget.usersRequestsCallBack(state.user.id);
          });
        } else if (state is SuccessApproveSignupUser) {
          setState(() {
            widget.usersRequestsCallBack(state.user.id);
          });
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
              Row(
                children: [
                  Container(
                    height: ScreenUtil().setSp(30),
                    width: ScreenUtil().setSp(30),
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
                    width: ScreenUtil().setWidth(8),
                  ),
                  Text(
                    widget.user.firstName + ' ' + widget.user.lastName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _getApprovmentCardState()
            ],
          ),
        ),
      ),
    );
  }

  _getApprovmentCardState() {
    return BlocBuilder(
      bloc: authsBloc,
      builder: (context, state) {
        if (state is ProcessingApproveSignupUser ||
            state is ProcessingRejectSignupUser) {
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
              strokeWidth: ScreenUtil().setWidth(3),
            ),
          );
        } else {
          return Row(
            children: [
              InkWell(
                  onTap: () => authsBloc.add(RejectSignupUser(widget.user.id)),
                  child: Icon(
                    Icons.close,
                    color: Colors.red,
                    size: ScreenUtil().setSp(35),
                  )),
              SizedBox(
                width: ScreenUtil().setWidth(20),
              ),
              InkWell(
                  onTap: () => authsBloc.add(ApproveSignupUser(widget.user.id)),
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                    size: ScreenUtil().setSp(35),
                  )),
            ],
          );
        }
      },
    );
  }
}
