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
  final User user;
  SuccessApproveSignupUser(this.user);
}

class ProcessingApproveSignupUser extends AuthsState {}

class ErrorApproveSignupUser extends AuthsState {
  final String error;

  ErrorApproveSignupUser(this.error);
}

// reject signup user
class SuccessRejectSignupUser extends AuthsState {
  final User user;
  SuccessRejectSignupUser(this.user);
}

class ProcessingRejectSignupUser extends AuthsState {}

class ErrorRejectSignupUser extends AuthsState {
  final String error;

  ErrorRejectSignupUser(this.error);
}

// for uplode image state
class UploaddingImage extends AuthsState {}

class SucessUploadImage extends AuthsState {
  final ImageModel image;

  SucessUploadImage(this.image);
}

class ErrorUploadImage extends AuthsState {
  final String error;

  ErrorUploadImage(this.error);
}
