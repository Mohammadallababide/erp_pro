part of 'invoice_bloc.dart';

@immutable
abstract class InvoiceState {}

class InvoiceInitial extends InvoiceState {}

// for getting all company invoices use cases ...
class GettingInvoices extends InvoiceState {}

class SuccessGettingInvoices extends InvoiceState {
  final List<Invoice> invoiceList;
  SuccessGettingInvoices(this.invoiceList);
}

class ErrorGettingInvoices extends InvoiceState {
  final String error;

  ErrorGettingInvoices(this.error);
}

// for create new invoice use cases ...
class CreattingInvoice extends InvoiceState {}

class SuccessCreattedInvoice extends InvoiceState {}

class ErrorCreattedInvoice extends InvoiceState {
  final String error;

  ErrorCreattedInvoice(this.error);
}

// for delete invoice use cases ...
class DelettingInvoice extends InvoiceState {}

class SuccessDelettedInvoice extends InvoiceState {
  final bool isSuccess;

  SuccessDelettedInvoice(this.isSuccess);
}

class ErrorDelettedInvoice extends InvoiceState {
  final String error;

  ErrorDelettedInvoice(this.error);
}

// for assign invoice use cases ...

class AssigningInvoiceToUser extends InvoiceState {}

class SuccessAssignedInvoiceToUser extends InvoiceState {
  final Invoice invoice;

  SuccessAssignedInvoiceToUser(this.invoice);
}

class ErrorAssignedInvoiceToUser extends InvoiceState {
  final String error;

  ErrorAssignedInvoiceToUser(this.error);
}

// for un assign invoice use cases ...

class UnAssigningInvoiceToUser extends InvoiceState {}

class SuccessUnAssignedInvoiceToUser extends InvoiceState {
  final Invoice invoice;

  SuccessUnAssignedInvoiceToUser(this.invoice);
}

class ErrorUnAssignedInvoiceToUser extends InvoiceState {
  final String error;

  ErrorUnAssignedInvoiceToUser(this.error);
}

// for review invoice use cases ...

class ReviewingInvoice extends InvoiceState {}

class SuccessReviewedInvoice extends InvoiceState {
  final Invoice invoice;

  SuccessReviewedInvoice(this.invoice);
}

class ErrorReviewedInvoice extends InvoiceState {
  final String error;

  ErrorReviewedInvoice(this.error);
}

// for approve invoice use cases ...

class ApprovingInvoice extends InvoiceState {}

class SuccessApprovedInvoice extends InvoiceState {
  final Invoice invoice;

  SuccessApprovedInvoice(this.invoice);
}

class ErrorApprovedInvoice extends InvoiceState {
  final String error;

  ErrorApprovedInvoice(this.error);
}

// for reject invoice use cases ...

class RejecttingInvoice extends InvoiceState {}

class SuccessRejectedInvoice extends InvoiceState {
  final Invoice invoice;

  SuccessRejectedInvoice(this.invoice);
}

class ErrorRejectedInvoice extends InvoiceState {
  final String error;

  ErrorRejectedInvoice(this.error);
}

// for mark as paid invoice use cases ...

class MarkAsPaidingInvoice extends InvoiceState {}

class SuccessMarkAsPaidedInvoice extends InvoiceState {
  final Invoice invoice;

  SuccessMarkAsPaidedInvoice(this.invoice);
}

class ErrorMarkAsPaidedInvoice extends InvoiceState {
  final String error;

  ErrorMarkAsPaidedInvoice(this.error);
}
