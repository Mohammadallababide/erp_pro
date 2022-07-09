part of 'leave_center_bloc.dart';

@immutable
abstract class LeaveCenterEvent {}

class CreateLeaveCategory extends LeaveCenterEvent {
  final String name;
  final int deductionAmount;

  CreateLeaveCategory({
    required this.name,
    required this.deductionAmount,
  });
}

class GetLeavesCategories extends LeaveCenterEvent {}

class DeleteLeaveCategory extends LeaveCenterEvent {
  final int id;

  DeleteLeaveCategory(this.id);
}

class CreateLeaveRequest extends LeaveCenterEvent {
  final int leaveCategoryId;
  final String description;
  final String fromDate;
  final String toDate;

  CreateLeaveRequest({
    required this.leaveCategoryId,
    required this.description,
    required this.fromDate,
    required this.toDate,
  });
}

class GetLeaves extends LeaveCenterEvent {}

class ApproveLeaveRequest extends LeaveCenterEvent {
  final int id;

  ApproveLeaveRequest(this.id);
}

class RejectLeaveRequest extends LeaveCenterEvent {
  final int id;
  RejectLeaveRequest(this.id);
}