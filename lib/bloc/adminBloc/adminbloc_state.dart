part of 'adminbloc_bloc.dart';

@immutable
abstract class AdminblocState {}

class AdminblocInitial extends AdminblocState {}

class SuccessChangedLeaveCategoryForUser extends AdminblocState {
  final User user;

  SuccessChangedLeaveCategoryForUser(this.user);
}

class ChangingLeaveCategoryForUser extends AdminblocState {}

class ErrorChangedLeaveCategoryForUser extends AdminblocState {
  final String error;

  ErrorChangedLeaveCategoryForUser(this.error);
}
