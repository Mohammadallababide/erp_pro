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

class DeleteInvoice extends InvoiceEvent {
  final int id;

  DeleteInvoice(this.id);
}

class AssignInvoiceToUser extends InvoiceEvent {
  final int id;
  final int userId;
  final String assignmentNote;

  AssignInvoiceToUser({
    required this.id,
    required this.userId,
    required this.assignmentNote,
  });
}

class UnAssignInvoiceToUser extends InvoiceEvent {
  final int id;
  final int userId;
  final String assignmentNote;

  UnAssignInvoiceToUser({
    required this.id,
    required this.userId,
    required this.assignmentNote,
  });
}

class ReviewInvoice extends InvoiceEvent {
  final int id;
  ReviewInvoice(this.id);
}

class ApproveInvoice extends InvoiceEvent {
  final int id;

  ApproveInvoice(this.id);
}

class MarkAsPaidInvoice extends InvoiceEvent {
  final int id;

  MarkAsPaidInvoice(this.id);
}

class RejectInvoice extends InvoiceEvent {
  final int id;

  RejectInvoice(this.id);
}

