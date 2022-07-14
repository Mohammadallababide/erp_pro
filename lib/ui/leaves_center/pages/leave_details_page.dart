import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../core/utils/app_flash_bar.dart';
import '../../../models/leave.dart';
import '../bloc/leave_center_bloc.dart';
import '../enum/leave_status.dart';
import '../widgets/LeaveWidget/LeavesCenterWidgets/leave_card.dart';

class LeaveDetailsPage extends StatefulWidget {
  final Leave leave;
  final Function actionCallBack;
  const LeaveDetailsPage(
      {Key? key, required this.leave, required this.actionCallBack})
      : super(key: key);

  @override
  State<LeaveDetailsPage> createState() => _LeaveDetailsPageState();
}

class _LeaveDetailsPageState extends State<LeaveDetailsPage> {
  final LeaveCenterBloc leaveCenterBloc = LeaveCenterBloc();

  late bool isLeaveStatusChanged = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context: context,
        title: 'Leave details',
      ),
      body: LeaveCard(
        item: widget.leave,
        showAllData: true,
      ),
      floatingActionButton: widget.leave.status ==
              LeaveStatus.pending_approval.toString().split('.')[1]
          ? buildFloattingctionsButton()
          : Container(),
    );
  }

  Widget buildFloattingctionsButton() {
    return BlocListener(
      listener: (context, state) {
        if (state is SuccessApprovedLeaveRequest) {
          getFlashBar(
            context: context,
            title: 'Mission Success',
            message: 'the Leave Request is Approved with success',
          );
          setState(() {
            isLeaveStatusChanged = true;
          });
        } else if (state is ErrorApprovedLeaveRequest) {
          getFlashBar(
            context: context,
            isErrorgMeg: true,
            title: 'Faild Mission',
            message: 'Faild Approving this Leave Request ',
          );
        } else if (state is SuccessRejectedLeaveRequest) {
          getFlashBar(
            context: context,
            title: 'Mission Success',
            message: 'the Leave Request is Rejected with success',
          );
          setState(() {
            isLeaveStatusChanged = true;
          });
        } else if (state is ErrorRejectedLeaveRequest) {
          getFlashBar(
            context: context,
            isErrorgMeg: true,
            title: 'Faild Mission',
            message: 'Faild Rejecting this Leave Request ',
          );
        }
      },
      bloc: leaveCenterBloc,
      child: !isLeaveStatusChanged
          ? BlocBuilder(
              bloc: leaveCenterBloc,
              builder: (context, state) {
                if (state is ApprovingLeaveRequest) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: Colors.greenAccent,
                    ),
                  );
                } else if (state is RejecttingLeaveRequest) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      heroTag: null,
                      child: Center(
                        child: Icon(Icons.close,
                            color: Colors.red, size: ScreenUtil().setSp(25)),
                      ),
                      onPressed: () => leaveCenterBloc.add(
                        RejectLeaveRequest(widget.leave.id),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(5),
                    ),
                    FloatingActionButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      heroTag: null,
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.greenAccent,
                          size: ScreenUtil().setSp(30),
                        ),
                      ),
                      onPressed: () => leaveCenterBloc.add(
                        ApproveLeaveRequest(widget.leave.id),
                      ),
                    ),
                  ],
                );
              })
          : Container(),
    );
  }
}
