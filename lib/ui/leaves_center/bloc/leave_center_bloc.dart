import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/remote_data_source/ServerApi.dart';
import '../../../models/leave.dart';
import '../../../models/leaveCategory.dart';

part 'leave_center_event.dart';
part 'leave_center_state.dart';

class LeaveCenterBloc extends Bloc<LeaveCenterEvent, LeaveCenterState> {
  LeaveCenterBloc() : super(LeaveCenterInitial()) {
    on<LeaveCenterEvent>((event, emit) {});
    // for leaves api
    on<GetLeaves>((event, emit) async {
      await _getLeaves(emit: emit);
    });
    on<CreateLeaveRequest>((event, emit) async {
      await _createLeaveRequest(
        leaveCategoryId: event.leaveCategoryId,
        description: event.description,
        fromDate: event.fromDate,
        toDate: event.toDate,
        emit: emit,
      );
    });
    on<ApproveLeaveRequest>((event, emit) async {
      await _approveLeaveRequest(emit: emit, id: event.id);
    });
    on<RejectLeaveRequest>((event, emit) async {
      await _rejectLeaveRequest(emit: emit, id: event.id);
    });
    // for leaveCategories api
    on<GetLeavesCategories>((event, emit) async {
      await _getLeavesCategories(emit: emit);
    });
    on<CreateLeaveCategory>((event, emit) async {
      await _createLeaveCategory(
          deductionAmount: event.deductionAmount, name: event.name, emit: emit);
    });
    on<DeleteLeaveCategory>((event, emit) async {
      await _deleteLeaveCategory(emit: emit, id: event.id);
    });
  }

  // for leave api
  Future<void> _createLeaveRequest({
    required int leaveCategoryId,
    required String description,
    required String fromDate,
    required String toDate,
    required Emitter<LeaveCenterState> emit,
  }) async {
    emit(CreattingLeaveRequest());
    try {
      Leave? result = await ServerApi.apiClient.createLeaveRequest(
        leaveCategoryId: leaveCategoryId,
        description: description,
        fromDate: fromDate,
        toDate: toDate,
      );
      emit(SuccessCreattedLeaveRequest(result!));
    } catch (e) {
      emit(ErrorCreattedLeaveRequest((e.toString())));
    }
  }

  Future<void> _getLeaves({
    required Emitter<LeaveCenterState> emit,
  }) async {
    emit(GettingLeavesRequests());
    try {
      List<Leave>? result = await ServerApi.apiClient.getLeaves();
      emit(SuccessGettedLeavesRequests(result!));
    } catch (e) {
      emit(ErrorGettedLeavesRequests((e.toString())));
    }
  }

  Future<void> _approveLeaveRequest({
    required int id,
    required Emitter<LeaveCenterState> emit,
  }) async {
    emit(ApprovingLeaveRequest());
    try {
      Leave? result = await ServerApi.apiClient.approveLeaveRequest(id);
      emit(SuccessApprovedLeaveRequest(result!));
    } catch (e) {
      emit(ErrorApprovedLeaveRequest((e.toString())));
    }
  }

  Future<void> _rejectLeaveRequest({
    required int id,
    required Emitter<LeaveCenterState> emit,
  }) async {
    emit(ReqjecttingLeaveRequest());
    try {
      Leave? result = await ServerApi.apiClient.approveLeaveRequest(id);
      emit(SuccessRejectedLeaveRequest(result!));
    } catch (e) {
      emit(ErrorRejectedLeaveRequest((e.toString())));
    }
  }

  // for leavesCategories api
  Future<void> _createLeaveCategory({
    required int deductionAmount,
    required String name,
    required Emitter<LeaveCenterState> emit,
  }) async {
    emit(CreattingLeaveCategory());
    try {
      LeaveCategory? result = await ServerApi.apiClient.createLeaveCategory(
        deductionAmount: deductionAmount,
        name: name,
      );
      emit(SuccessCreattedLeaveCategory(result!));
    } catch (e) {
      emit(ErrorCreattedLeaveCategory((e.toString())));
    }
  }

  Future<void> _getLeavesCategories({
    required Emitter<LeaveCenterState> emit,
  }) async {
    emit(GettingLeavesCategories());
    try {
      List<LeaveCategory>? result =
          await ServerApi.apiClient.getLeavesCategories();
      emit(SuccessGettedCategories(result!));
    } catch (e) {
      emit(ErrorGettedCategories((e.toString())));
    }
  }

  Future<void> _deleteLeaveCategory({
    required int id,
    required Emitter<LeaveCenterState> emit,
  }) async {
    emit(DelettingLeaveCategory());
    try {
      await ServerApi.apiClient.deleteLeaveCategorie(id);
      emit(SuccessDelettedLeaveCategory());
    } catch (e) {
      emit(ErrorDelettedLeaveCategory((e.toString())));
    }
  }
}
