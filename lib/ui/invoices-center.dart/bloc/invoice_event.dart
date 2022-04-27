part of 'invoice_bloc.dart';

@immutable
abstract class InvoiceEvent {}

class GetInvoices extends InvoiceEvent {
  final int? page;
  final int? limit;

  GetInvoices({this.page, this.limit});
}

class CreateIvoice extends InvoiceEvent {
  final int grossAmount;
  final int netAmount;
  final String taxNumber;
  final String filePath;
  final String dueDate;
  final String issueDate;

  CreateIvoice({
    required this.grossAmount,
    required this.netAmount,
    required this.taxNumber,
    required this.filePath,
    required this.dueDate,
    required this.issueDate,
  });
}
