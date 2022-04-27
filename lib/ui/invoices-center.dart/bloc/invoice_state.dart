part of 'invoice_bloc.dart';

@immutable
abstract class InvoiceState {}

class InvoiceInitial extends InvoiceState {}

class GettingInvoices extends InvoiceState {}

class SuccessGettingInvoices extends InvoiceState {
  final List<Invoice> invoiceList;
  SuccessGettingInvoices(this.invoiceList);
}

class ErrorGettingInvoices extends InvoiceState {
  final String error;

  ErrorGettingInvoices(this.error);
}

class CreattingInvoice extends InvoiceState {}

class SuccessCreattedInvoice extends InvoiceState {}

class ErrorCreattedInvoice extends InvoiceState {
  final String error;

  ErrorCreattedInvoice(this.error);
}
