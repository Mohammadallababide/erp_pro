part of 'auths_bloc.dart';

abstract class AuthsState {}

class AuthsInitial extends AuthsState {}

class SuccessSingUp extends AuthsState {
  final String message;

  SuccessSingUp(this.message);
}

class ErrorSingUp extends AuthsState {
  final String? error;

  ErrorSingUp(this.error);
}

class SuccessSingIn extends AuthsState {
  final User? user;

  SuccessSingIn(this.user);
}

class ErrorSingIn extends AuthsState {
  final String? error;

  ErrorSingIn(this.error);
}

class AuthProcessing extends AuthsState {}

//  just for Addmin
//  ---------------
class SucessGettingSignupUsersRequests extends AuthsState {
 final List<User> users;
 SucessGettingSignupUsersRequests(this.users);
}
class GettingSignupUsersRequests extends AuthsState {}

class ErrorGettingSignupUsersRequests extends AuthsState {
  final String erorr;
  ErrorGettingSignupUsersRequests(this.erorr);
}

// approve signup user
class SuccessApproveSignupUser extends AuthsState {
  final bool isSuccess;
  SuccessApproveSignupUser(this.isSuccess);
}

class ProcessingApproveSignupUser extends AuthsState {}

class ErrorApproveSignupUser extends AuthsState {
  final String error;

  ErrorApproveSignupUser(this.error);
}