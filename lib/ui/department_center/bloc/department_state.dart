part of 'department_bloc.dart';

@immutable
abstract class DepartmentState {}

class DepartmentInitial extends DepartmentState {}

class GettingDepartments extends DepartmentState {
  GettingDepartments();
}

class SuccessGettedDepartment extends DepartmentState {
  final List<Department> department;

  SuccessGettedDepartment(this.department);
}

class ErrorGettedDepatment extends DepartmentState {
  final String error;

  ErrorGettedDepatment(this.error);
}

class CreattingNewDepartment extends DepartmentState {}

class SuccessCreattedDepartment extends DepartmentState {
  SuccessCreattedDepartment();
}

class ErrorCreattedDepartment extends DepartmentState {
  final String error;

  ErrorCreattedDepartment(this.error);
}

class AddingUsersToDepartment extends DepartmentState {}

class SuccessAddedUsersToDepartment extends DepartmentState {}

class ErrorAddedUsersToDepartment extends DepartmentState {
  final String error;

  ErrorAddedUsersToDepartment(this.error);
}

class MarkingUserAsMangerOfDepartment extends DepartmentState {}

class SuccessMarkedUserAsMangerOfDepartment extends DepartmentState {}

class ErrorMarkedUserAsMangerOfDepartment extends DepartmentState {
  final String error;
  ErrorMarkedUserAsMangerOfDepartment(this.error);
}

class EdittingDepartment extends DepartmentState {}

class SuccessEdittedDepartment extends DepartmentState {
  final Department department;

  SuccessEdittedDepartment(this.department);
}

class ErrorEdittedDepartment extends DepartmentState {
  final String error;

  ErrorEdittedDepartment(this.error);
}

class DelttingDepartment extends DepartmentState {}

class SuccessDelettedDepartment extends DepartmentState {}

class ErrorDelettedDepartment extends DepartmentState {
  final String error;

  ErrorDelettedDepartment(this.error);
}

class GettingDepartmentById extends DepartmentState {
  GettingDepartmentById();
}

class SuccessGettedDepartmentById extends DepartmentState {
  final Department department;

  SuccessGettedDepartmentById(this.department);
}

class ErrorGettedDepatmentById extends DepartmentState {
  final String error;

  ErrorGettedDepatmentById(this.error);
}
