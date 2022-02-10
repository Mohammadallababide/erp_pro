import 'package:erb_mobo/common/common_widgets/app_snack_bar.dart';
import 'package:erb_mobo/models/user.dart';
import 'package:erb_mobo/ui/approvment_request_list/widgets/request_approvment_card.dart';
import 'package:erb_mobo/ui/auths/bloc/auths_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApprovmentRequestsList extends StatefulWidget {
  const ApprovmentRequestsList({Key? key}) : super(key: key);

  @override
  State<ApprovmentRequestsList> createState() => _ApprovmentRequestsListState();
}

class _ApprovmentRequestsListState extends State<ApprovmentRequestsList> {
  late bool isFinishGettingUsersSignupRequests = false;
  List<User> usersRequests = [];
  final AuthsBloc authsBloc = AuthsBloc();
  @override
  void initState() {
    authsBloc.add(GetUsersSignupRequests());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: authsBloc,
      listener: (context, state) {
        if (state is SucessGettingSignupUsersRequests) {
          setState(() {
            isFinishGettingUsersSignupRequests = true;
            usersRequests = state.users.reversed.toList();
          });
        } else if (state is ErrorGettingSignupUsersRequests) {
          ScaffoldMessenger.of(context).showSnackBar(
              getAppSnackBar(message: 'Faild Process!!', context: context));
          setState(() {
            isFinishGettingUsersSignupRequests = true;
            usersRequests = [];
          });
        }
      },
      child: isFinishGettingUsersSignupRequests
          ? ListView.builder(
              itemCount: usersRequests.length,
              itemBuilder: (BuildContext context, int index) {
                return RequestApprovmentCard(
                  user: usersRequests[index],
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
    );
  }
}
