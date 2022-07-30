import 'package:erb_mobo/ui/user_profile/bloc/user_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/costant.dart';
import '../widgets/userProfilePageWidgets/profile_content.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserProfileBloc userProfileBloc = UserProfileBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userProfileBloc.add(GetUserProfile(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: ConstatValues.baseGradientColor,
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        body: BlocBuilder(
            bloc: userProfileBloc,
            builder: (context, state) {
              if (state is SuccessGettedUserProfile) {
                return ProfileContent(user: state.user);
              } else if (state is GettingUserProfile) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            }),
      ),
    );
  }
}
