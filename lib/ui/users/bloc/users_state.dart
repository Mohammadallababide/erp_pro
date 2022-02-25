part of 'users_bloc.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class GettingUsers extends UsersState {}

class SuccessGetUsers extends UsersState {
  final List<User> users;

  SuccessGetUsers(this.users);
}

class ErrorGetUsers extends UsersState {
  final String error;

  ErrorGetUsers(this.error);
}
