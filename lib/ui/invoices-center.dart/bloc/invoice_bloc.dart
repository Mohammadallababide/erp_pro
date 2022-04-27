import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/remote_data_source/ServerApi.dart';
import '../../../models/invoice.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc() : super(InvoiceInitial()) {
    on<GetInvoices>((event, emit) async {
      await _getInvoices(
          emit: emit, page: event.page ?? 1, limit: event.limit ?? 1);
    });
    on<CreateIvoice>((event, emit) async {
      await _createInvoice(
        emit: emit,
        grossAmount: event.grossAmount,
        netAmount: event.netAmount,
        dueDate: event.dueDate,
        issueDate: event.issueDate,
        taxNumber: event.taxNumber,
        filePath: event.filePath,
      );
    });
  }

  Future<void> _createInvoice({
    required int grossAmount,
    required int netAmount,
    required String taxNumber,
    required String filePath,
    required String dueDate,
    required String issueDate,
    required Emitter<InvoiceState> emit,
  }) async {
    emit(CreattingInvoice());
    try {
       await ServerApi.apiClient.createIvoice(
          dueDate: dueDate,
          taxNumber: taxNumber,
          grossAmount: grossAmount,
          issueDate: issueDate,
          filepath: filePath,
          netAmount: netAmount);
      emit(SuccessCreattedInvoice());
    } catch (e) {
      emit(ErrorCreattedInvoice((e.toString())));
    }
  }

  Future<void> _getInvoices({
    required int page,
    required int limit,
    required Emitter<InvoiceState> emit,
  }) async {
    emit(GettingInvoices());
    try {
      final List<Invoice> result = await ServerApi.apiClient.getInvoices();
      emit(SuccessGettingInvoices(result));
    } catch (e) {
      emit(ErrorGettingInvoices((e.toString())));
    }
  }
}
