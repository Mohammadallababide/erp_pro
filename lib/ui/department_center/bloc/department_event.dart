part of 'department_bloc.dart';

@immutable
abstract class DepartmentEvent {}

class CreateNewDepartment extends DepartmentEvent {
  final String title;
  final int maxNumberOfEmployees;

  CreateNewDepartment({
    required this.title,
    required this.maxNumberOfEmployees,
  });
}

class GetDepartments extends DepartmentEvent {}

class EditDepartment extends DepartmentEvent {
  final String title;
  final int maxNumberOfEmployees;
  final int id;
  EditDepartment({
    required this.title,
    required this.maxNumberOfEmployees,
    required this.id,
  });
}

class DeleteDepartment extends DepartmentEvent {
  final int id;

  DeleteDepartment(this.id);
}

class AddUserToDepartment extends DepartmentEvent {
  final List<int> usersId;
  final int id;

  AddUserToDepartment({
    required this.usersId,
    required this.id,
  });
}

class MarkUsersAsMangerOfDepartment extends DepartmentEvent {
  final int userId;
  final int id;

  MarkUsersAsMangerOfDepartment({
    required this.userId,
    required this.id,
  });
}
