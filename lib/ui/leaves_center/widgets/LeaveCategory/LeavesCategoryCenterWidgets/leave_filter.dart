import 'package:flutter/material.dart';

import '../../../../../models/leave.dart';
import '../../LeaveWidget/LeavesCenterWidgets/leave_card.dart';

class LeaveFilter extends StatelessWidget {
  final List<Leave> leaves;
  const LeaveFilter({Key? key, required this.leaves}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: leaves.length,
      itemBuilder: (BuildContext context, int index) {
        return LeaveCard(
          item: leaves[index],
          showAllData: false,
        );
      },
    );
  }
}
