part of 'common_app_bloc.dart';

@immutable
abstract class CommonAppState {}

class CommonAppInitial extends CommonAppState {}

class SuccessGetAppFile extends CommonAppState {
  final AppFile file;

  SuccessGetAppFile(this.file);
}

class GettingAppFile extends CommonAppState {}

class ErrorGettingAppFile extends CommonAppState {
  final String error;

  ErrorGettingAppFile(this.error);
}
