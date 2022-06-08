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
        dueDate: event.dueDate,
        filePath: event.filePath,
        grossAmount: event.grossAmount,
        issueDate: event.issueDate,
        netAmount: event.netAmount,
        taxNumber: event.taxNumber,
      );
    });

    on<DeleteInvoice>((event, emit) async {
      await _deleteInvoice(emit: emit, id: event.id);
    });
    on<RejectInvoice>((event, emit) async {
      await _rejectInvoice(id: event.id, emit: emit);
    });
    on<AssignInvoiceToUser>((event, emit) async {
      await _assignInvoiceToUser(
          id: event.id,
          userId: event.userId,
          assignmentNote: event.assignmentNote,
          emit: emit);
    });
    on<UnAssignInvoiceToUser>((event, emit) async {
      await _unAssignInvoiceToUser(
          id: event.id,
          userId: event.userId,
          assignmentNote: event.assignmentNote,
          emit: emit);
    });
    on<ApproveInvoice>((event, emit) async {
      await _approveInvoice(id: event.id, emit: emit);
    });
    on<MarkAsPaidInvoice>((event, emit) async {
      await _markAsPaidInvoice(id: event.id, emit: emit);
    });
    on<ReviewInvoice>((event, emit) async {
      await _reviewInvoice(id: event.id, emit: emit);
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

  Future<void> _deleteInvoice({
    required int id,
    required Emitter<InvoiceState> emit,
  }) async {
    emit(DelettingInvoice());
    try {
      bool? res = await ServerApi.apiClient.deleteInvoice(id);
      emit(SuccessDelettedInvoice(res!));
    } catch (e) {
      emit(ErrorDelettedInvoice(e.toString()));
    }
  }

  Future<void> _assignInvoiceToUser({
    required int id,
    required int userId,
    required String assignmentNote,
    required Emitter<InvoiceState> emit,
  }) async {
    emit(AssigningInvoiceToUser());
    try {
      Invoice? inv = await ServerApi.apiClient.assignInvoiceToUser(
        id: id,
        userId: userId,
        assignmentNote: assignmentNote,
      );
      emit(SuccessAssignedInvoiceToUser(inv!));
    } catch (e) {
      emit(ErrorAssignedInvoiceToUser(e.toString()));
    }
  }

  Future<void> _unAssignInvoiceToUser({
    required int id,
    required int userId,
    required String assignmentNote,
    required Emitter<InvoiceState> emit,
  }) async {
    emit(UnAssigningInvoiceToUser());
    try {
      Invoice? inv = await ServerApi.apiClient.unAssignInvoiceToUser(
        id: id,
        userId: userId,
        assignmentNote: assignmentNote,
      );
      emit(SuccessUnAssignedInvoiceToUser(inv!));
    } catch (e) {
      emit(ErrorUnAssignedInvoiceToUser(e.toString()));
    }
  }

  Future<void> _reviewInvoice({
    required int id,
    required Emitter<InvoiceState> emit,
  }) async {
    emit(ReviewingInvoice());
    try {
      Invoice? inv = await ServerApi.apiClient.reviewInvoice(id);
      emit(SuccessReviewedInvoice(inv!));
    } catch (e) {
      emit(ErrorReviewedInvoice(e.toString()));
    }
  }

  Future<void> _approveInvoice({
    required int id,
    required Emitter<InvoiceState> emit,
  }) async {
    emit(ApprovingInvoice());
    try {
      Invoice? inv = await ServerApi.apiClient.approveInvoice(id);
      emit(SuccessApprovedInvoice(inv!));
    } catch (e) {
      emit(ErrorApprovedInvoice(e.toString()));
    }
  }

  Future<void> _rejectInvoice({
    required int id,
    required Emitter<InvoiceState> emit,
  }) async {
    emit(RejecttingInvoice());
    try {
      Invoice? inv = await ServerApi.apiClient.rejectInvoice(id);
      emit(SuccessRejectedInvoice(inv!));
    } catch (e) {
      emit(ErrorRejectedInvoice(e.toString()));
    }
  }

  Future<void> _markAsPaidInvoice({
    required int id,
    required Emitter<InvoiceState> emit,
  }) async {
    emit(MarkAsPaidingInvoice());
    try {
      Invoice? inv = await ServerApi.apiClient.markAsPaidInvoice(id);
      emit(SuccessMarkAsPaidedInvoice(inv!));
    } catch (e) {
      emit(ErrorMarkAsPaidedInvoice(e.toString()));
    }
  }

  Future<void> _getInvoices({
    required int page,
    required int limit,
    required Emitter<InvoiceState> emit,
  }) async {
    emit(GettingInvoices());
    try {
      final List<Invoice>? result = await ServerApi.apiClient.getInvoices();
      emit(SuccessGettingInvoices(result!));
    } catch (e) {
      emit(ErrorGettingInvoices((e.toString())));
    }
  }
}
