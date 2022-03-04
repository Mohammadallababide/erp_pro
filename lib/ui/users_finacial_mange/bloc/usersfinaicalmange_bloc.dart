import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/remote_data_source/ServerApi.dart';
import '../../../models/deduction.dart';
import '../../../models/receipt.dart';
import '../../../models/salary.dart';

part 'usersfinaicalmange_event.dart';
part 'usersfinaicalmange_state.dart';

class UsersfinaicalmangeBloc
    extends Bloc<UsersfinaicalmangeEvent, UsersfinaicalmangeState> {
  UsersfinaicalmangeBloc() : super(UsersfinaicalmangeInitial()) {
    on<GetReceipts>((event, emit) async {
      await _getReceipt(emit: emit, page: event.page);
    });

    on<CreateReceipt>((event, emit) async {
      await _createReceipt(
          emit: emit,
          userId: event.userId,
          salary: event.salary,
          deductions: event.deductions);
    });

    on<DeleteReceipt>((event, emit) async {
      await _deleteReceipt(emit: emit, id: event.id);
    });
  }

  Future<void> _deleteReceipt({
    required Emitter<UsersfinaicalmangeState> emit,
    required int id,
  }) async {
    try {
      emit(DeletingReceipt());
      Receipt? receipt = await ServerApi.apiClient.deleteReceipt(id);
      emit(SuccessDeletingReceipt(receipt!));
    } catch (e) {
      emit(ErrorDeletingReceipt((e.toString())));
    }
  }

  Future<void> _createReceipt({
    required int userId,
    required Salary salary,
    required List<Deduction> deductions,
    required Emitter<UsersfinaicalmangeState> emit,
  }) async {
    try {
      emit(CreatingReceipt());
      final Receipt? receipt =
          await ServerApi.apiClient.createReceipt(userId, salary, deductions);
      emit(SuccessCreatingReceipt(receipt!));
    } catch (e) {
      emit(ErrorCreatingReceipt((e.toString())));
    }
  }

  Future<void> _getReceipt({
    required int page,
    required Emitter<UsersfinaicalmangeState> emit,
  }) async {
    emit(GettingReceipts());
    try {
      final List<Receipt> result = await ServerApi.apiClient.getReceipts(page);
      emit(SuccessGettinReceipts(result));
    } catch (e) {
      emit(ErrorGettingReceipts((e.toString())));
    }
  }
}
