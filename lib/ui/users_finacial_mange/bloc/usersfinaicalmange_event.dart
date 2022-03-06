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
  final int receiptId;
  final Salary salary;
  final List<Deduction> deductions;

  EditReceipt({
    required this.receiptId,
    required this.salary,
    required this.deductions,
  });
}

class DeleteReceipt extends UsersfinaicalmangeEvent {
  final int id;

  DeleteReceipt(this.id);
}
