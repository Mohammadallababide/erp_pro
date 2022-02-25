part of 'myprofilebloc_bloc.dart';

@immutable
abstract class MyprofileblocState {}

class MyprofileblocInitial extends MyprofileblocState {}


class SuccessFetchMyProfileInfo extends MyprofileblocState{
 final  User user;

  SuccessFetchMyProfileInfo(this.user);
}

class ErrorFetchMyProfileInfo extends MyprofileblocState {
  final String error;

  ErrorFetchMyProfileInfo(this.error);

}

class FetchingMyProfileInfo extends MyprofileblocState {}
