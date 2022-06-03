part of 'usersfinaicalmange_bloc.dart';

@immutable
abstract class UsersfinaicalmangeEvent {}

class GetReceipts extends UsersfinaicalmangeEvent {
  final int page;

  GetReceipts(this.page);
}

class CreateReceipt extends UsersfinaicalmangeEvent {
  final int userId;
  final Salary salary;
  final List<Deduction> deductions;

  CreateReceipt({
    required this.userId,
    required this.salary,
    required this.deductions,
  });
}

class EditReceipt extends UsersfinaicalmangeEvent {
  final Receipt receipt;
  final Salary salary;
  final List<Deduction> deductions;

  EditReceipt({
    required this.receipt,
    required this.salary,
    required this.deductions,
  });
}

class DeleteReceipt extends UsersfinaicalmangeEvent {
  final int id;

  DeleteReceipt(this.id);
}
