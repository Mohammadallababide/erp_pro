part of 'auths_bloc.dart';

abstract class AuthsEvent {}

class SingUp extends AuthsEvent {
  final String firstName;
  final String lastName;
  final String password;
  final String email;
  final String phoneNumber;
  SingUp({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.email,
    required this.phoneNumber,
  });
}

class SingIn extends AuthsEvent {
  final String password;
  final String email;

  SingIn({
    required this.password,
    required this.email,
  });
}

//  just for Addmin
//  ---------------
class GetUsersSignupRequests extends AuthsEvent {}

class ApproveSignupUser extends AuthsEvent {
  final int id;
  final int departmentId;

  ApproveSignupUser({
    required this.id,
    required this.departmentId,
  });
}

class RejectSignupUser extends AuthsEvent {
  final int id;

  RejectSignupUser(this.id);
}

// for upload image internet
class UploadImage extends AuthsEvent {
  final String filePath;

  UploadImage(this.filePath);
}
