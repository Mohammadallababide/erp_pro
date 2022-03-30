part of 'salaryscales_bloc.dart';

@immutable
abstract class SalaryScalesState {}

class SalaryScalesInitial extends SalaryScalesState {}

class GettingSalaryScales extends SalaryScalesState {}

class SuccessGettingSalaryScales extends SalaryScalesState {
  final List<SalaryScale> salaryScales;

  SuccessGettingSalaryScales(this.salaryScales);
}

class ErrorGettingSalaryScales extends SalaryScalesState {
  final String error;

  ErrorGettingSalaryScales(this.error);
}

class CreattingSalaryScale extends SalaryScalesState {}

class SuccessCreattingSalaryScale extends SalaryScalesState {
  final SalaryScale salaryScale;

  SuccessCreattingSalaryScale(this.salaryScale);
}

class ErrorCreattingSalaryScale extends SalaryScalesState {
  final String error;

  ErrorCreattingSalaryScale(this.error);
}

class DelettingSalaryScale extends SalaryScalesState {}

class SuccessDelettingSalaryScale extends SalaryScalesState {}

class ErrorDelettingSalaryScale extends SalaryScalesState {
  final String error;

  ErrorDelettingSalaryScale(this.error);
}

class ActivatingSalaryScale extends SalaryScalesState {}

class SuccessAcivateSalaryScale extends SalaryScalesState {
  final bool isSuccess;

  SuccessAcivateSalaryScale(this.isSuccess);
}

class ErrorActivateSalaryScale extends SalaryScalesState {
  final String error;

  ErrorActivateSalaryScale(this.error);
}
