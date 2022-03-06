part of 'usersfinaicalmange_bloc.dart';

@immutable
abstract class UsersfinaicalmangeState {}

class UsersfinaicalmangeInitial extends UsersfinaicalmangeState {}

// for get receipts
class GettingReceipts extends UsersfinaicalmangeState {}

class SuccessGettinReceipts extends UsersfinaicalmangeState {
  final List<Receipt> receipts;

  SuccessGettinReceipts(this.receipts);
}

class ErrorGettingReceipts extends UsersfinaicalmangeState {
  final String error;

  ErrorGettingReceipts(this.error);
}

// for create receipt
class CreatingReceipt extends UsersfinaicalmangeState {}

class SuccessCreatingReceipt extends UsersfinaicalmangeState {
  final Receipt receipt;

  SuccessCreatingReceipt(this.receipt);
}

class ErrorCreatingReceipt extends UsersfinaicalmangeState {
  final String error;

  ErrorCreatingReceipt(this.error);
}

// for edit receipt
class EditingReceipt extends UsersfinaicalmangeState {}

class SuccessEditingReceipt extends UsersfinaicalmangeState {
  final Receipt receipt;

  SuccessEditingReceipt(this.receipt);
}

class ErrorEditingReceipt extends UsersfinaicalmangeState {
  final String error;

  ErrorEditingReceipt(this.error);
}

// for delete recipt
class DeletingReceipt extends UsersfinaicalmangeState {}

class SuccessDeletingReceipt extends UsersfinaicalmangeState {
  final Receipt receipt;

  SuccessDeletingReceipt(this.receipt);
}

class ErrorDeletingReceipt extends UsersfinaicalmangeState {
  final String error;

  ErrorDeletingReceipt(this.error);
}
