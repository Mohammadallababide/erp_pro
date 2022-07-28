part of 'user_profile_bloc.dart';

@immutable
abstract class UserProfileEvent {}

class GetUserProfile extends UserProfileEvent {
  final int id;

  GetUserProfile(this.id);
}

class GetMyProfile extends UserProfileEvent {}
