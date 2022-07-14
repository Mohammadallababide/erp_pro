part of 'leave_center_bloc.dart';

@immutable
abstract class LeaveCenterState {}

class LeaveCenterInitial extends LeaveCenterState {}

// state for Leave Categorie Api

class GettingLeavesCategories extends LeaveCenterState {
}

class SuccessGettedCategories extends LeaveCenterState {
   final List<LeaveCategory> leaveCategories;

  SuccessGettedCategories(this.leaveCategories);
}

class ErrorGettedCategories extends LeaveCenterState {
  final String error;

  ErrorGettedCategories(this.error);
}

class CreattingLeaveCategory extends LeaveCenterState {
}

class SuccessCreattedLeaveCategory extends LeaveCenterState {
  final LeaveCategory result;

  SuccessCreattedLeaveCategory(this.result);
}

class ErrorCreattedLeaveCategory extends LeaveCenterState {
  final String error;

  ErrorCreattedLeaveCategory(this.error);
}

class DelettingLeaveCategory extends LeaveCenterState {
  
}

class SuccessDelettedLeaveCategory extends LeaveCenterState {

}

class ErrorDelettedLeaveCategory extends LeaveCenterState {
  final String error;

  ErrorDelettedLeaveCategory(this.error);

}

// state for Leave Api

class GettingLeavesRequests extends LeaveCenterState {

}

class SuccessGettedLeavesRequests extends LeaveCenterState {
  final List<Leave> leaves;

  SuccessGettedLeavesRequests(this.leaves);
}

class ErrorGettedLeavesRequests extends LeaveCenterState {
  final String error;

  ErrorGettedLeavesRequests(this.error);

}

class CreattingLeaveRequest extends LeaveCenterState {
  
}

class SuccessCreattedLeaveRequest extends LeaveCenterState {
  final Leave result;

  SuccessCreattedLeaveRequest(this.result);
}

class ErrorCreattedLeaveRequest extends LeaveCenterState {
 final String error;

  ErrorCreattedLeaveRequest(this.error);
}

class ApprovingLeaveRequest extends LeaveCenterState {

}

class SuccessApprovedLeaveRequest extends LeaveCenterState {
  final Leave result;

  SuccessApprovedLeaveRequest(this.result);
}

class ErrorApprovedLeaveRequest extends LeaveCenterState {
  final String error;

  ErrorApprovedLeaveRequest(this.error);
}

class RejecttingLeaveRequest extends LeaveCenterState {

}

class SuccessRejectedLeaveRequest extends LeaveCenterState {
  final Leave result;

  SuccessRejectedLeaveRequest(this.result);
}

class ErrorRejectedLeaveRequest extends LeaveCenterState {
  final String error;

  ErrorRejectedLeaveRequest(this.error);
}

