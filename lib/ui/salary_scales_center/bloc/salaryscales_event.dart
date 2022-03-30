part of 'salaryscales_bloc.dart';

@immutable
abstract class SalaryScalesEvent {}

class CreateSalaryScales extends SalaryScalesEvent {
  final List<SalaryScaleJob> salaryScaleJobs;

  CreateSalaryScales(this.salaryScaleJobs);
}

class GetCompanySalaryScales extends SalaryScalesEvent {}

class ActivateSalaryScale extends SalaryScalesEvent {
  final int id;

  ActivateSalaryScale(this.id);
}

class DeleteSalaryScale extends SalaryScalesEvent {
  final int id;

  DeleteSalaryScale(this.id);
}
