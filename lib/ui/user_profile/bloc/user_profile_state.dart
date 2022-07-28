part of 'user_profile_bloc.dart';

@immutable
abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class GettingUserProfile extends UserProfileState {}

class SuccessGettedUserProfile extends UserProfileState {
  final User user;

  SuccessGettedUserProfile(this.user);
}

class ErrorGettedUserProfile extends UserProfileState {
  final String error;

  ErrorGettedUserProfile(this.error);
}

class GettingMyProfile extends UserProfileState {}


class SuccessGettedMyProfile extends UserProfileState {
  final User user;

  SuccessGettedMyProfile(this.user);
}

class ErrorGettedMyProfile extends UserProfileState {
  final String error;

  ErrorGettedMyProfile(this.error);
}
