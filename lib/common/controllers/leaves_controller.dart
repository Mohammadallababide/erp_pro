import 'package:erb_mobo/models/leave.dart';

import '../../ui/leaves_center/enum/leave_status.dart';

class LeavesController {
  final List<Leave> leaves;

  LeavesController(this.leaves);

  List<Leave> getPendingApprovalLeaves() {
    List<Leave> result = [];
    leaves.forEach((element) {
      if (element.status ==
          LeaveStatus.pending_approval.toString().split('.')[1]) {
        result.add(element);
      }
    });
    return result;
  }

   List<Leave> getArchivedLeaves() {
    List<Leave> result = [];
    leaves.forEach((element) {
      if (element.status !=
          LeaveStatus.pending_approval.toString().split('.')[1]) {
        result.add(element);
      }
    });
    return result;
  }
}
