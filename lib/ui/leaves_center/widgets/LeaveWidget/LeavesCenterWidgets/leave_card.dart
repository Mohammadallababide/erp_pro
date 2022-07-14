import 'package:erb_mobo/ui/leaves_center/enum/leave_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;
import '../../../../../common/generate_screen.dart';
import '../../../../../core/utils/core_util_function.dart';
import '../../../../../models/leave.dart';

class LeaveCard extends StatefulWidget {
  final Leave item;
  final bool showAllData;

  const LeaveCard({
    Key? key,
    required this.showAllData,
    required this.item,
  }) : super(key: key);

  @override
  State<LeaveCard> createState() => _LeaveCardState();
}

class _LeaveCardState extends State<LeaveCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(5),
          vertical: ScreenUtil().setHeight(3),
        ),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ScreenUtil().radius(15),
            ),
          ),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(12),
              vertical: ScreenUtil().setHeight(14),
            ),
            child: !widget.showAllData
                ? buildShortcutLeaveInfoContent()
                : buildAllLeaveInfoContent(),
          ),
        ),
      ),
    );
  }

  Widget buildShortcutLeaveInfoContent() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, NameScreen.leaveDetailsPage, arguments: {
          'leave': widget.item,
        });
      },
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildSharedSection(),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Icon(
              widget.item.status ==
                      LeaveStatus.pending_approval.toString().split('.')[1]
                  ? Icons.hourglass_top
                  : widget.item.status ==
                          LeaveStatus.approved.toString().split('.')[1]
                      ? Icons.check_circle
                      : Icons.cancel,
              color: Theme.of(context).primaryColor,
              size: ScreenUtil().setSp(25),
            ),
          )
        ],
      ),
    );
  }

  Widget buildAllLeaveInfoContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        buildSharedSection(),
        SizedBox(
          height: ScreenUtil().setHeight(5),
        ),
        buildCategoryInfoSection(),
        SizedBox(
          height: ScreenUtil().setHeight(5),
        ),
        buildDateInfoSection(isStartDate: true),
        SizedBox(
          height: ScreenUtil().setHeight(5),
        ),
        buildDateInfoSection(isStartDate: false),
        SizedBox(
          height: ScreenUtil().setHeight(5),
        ),
        buildDescraptionInfoSection(),
        SizedBox(
          height: ScreenUtil().setHeight(5),
        ),
        buildLeaveStatusInfoSection(),
        SizedBox(
          height: ScreenUtil().setHeight(5),
        ),
      ],
    );
  }

  Widget buildLeaveStatusInfoSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Leave Status :',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
          fontSize: ScreenUtil().setSp(15),
        ),
      ),
      ListTile(
        title: Text(
          widget.item.status!,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(14)),
        ),
        leading: Icon(
          Icons.help_center_outlined,
          color: Theme.of(context).primaryColor,
        ),
        trailing: Icon(
          widget.item.status ==
                  LeaveStatus.pending_approval.toString().split('.')[1]
              ? Icons.hourglass_top
              : widget.item.status ==
                      LeaveStatus.approved.toString().split('.')[1]
                  ? Icons.check_circle
                  : Icons.cancel,
          color: Theme.of(context).primaryColor,
        ),
      ),
    ]);
  }

  Widget buildSharedSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.access_time_filled,
                color: Theme.of(context).primaryColor,
                size: ScreenUtil().setSp(14),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(6),
              ),
              Text(
                "${CorerUtilFunction.getFormalDate(
                  '2022-05-18',
                )}",
                textDirection: ui.TextDirection.rtl,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(5),
        ),
        buildRequesterInfoSection(),
      ],
    );
  }

  Widget buildRequesterInfoSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Leave requester :',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
          fontSize: ScreenUtil().setSp(15),
        ),
      ),
      ListTile(
        title: Text(
          widget.item.requester!.firstName +
              ' ' +
              widget.item.requester!.lastName,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(14)),
        ),
        subtitle: Text('role :' + ' '),
        leading: Icon(
          Icons.account_circle,
          color: Theme.of(context).primaryColor,
        ),
      ),
    ]);
  }

  Widget buildCategoryInfoSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Leave Category :',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
          fontSize: ScreenUtil().setSp(15),
        ),
      ),
      ListTile(
        title: Text(
          widget.item.categoryName!,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(14)),
        ),
        subtitle:
            Text('deduction amount :' + widget.item.deductionAmount.toString()),
        leading: Icon(
          Icons.category_outlined,
          color: Theme.of(context).primaryColor,
        ),
      ),
    ]);
  }

  Widget buildDateInfoSection({required bool isStartDate}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        isStartDate ? 'Leave start in :' : 'Leave end in :',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
          fontSize: ScreenUtil().setSp(15),
        ),
      ),
      ListTile(
        title: Text(
          isStartDate
              ? CorerUtilFunction.getFormalDate(widget.item.fromDate)
              : CorerUtilFunction.getFormalDate(widget.item.toDate),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(14)),
        ),
        subtitle: Text(
          'at Time : ' +
              (isStartDate
                  ? CorerUtilFunction.getFormalDateForHours(
                      widget.item.fromDate)
                  : CorerUtilFunction.getFormalDateForHours(
                      widget.item.toDate)),
        ),
        leading: Icon(
          Icons.date_range,
          color: Theme.of(context).primaryColor,
        ),
      ),
    ]);
  }

  Widget buildDescraptionInfoSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Leave end in :',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
          fontSize: ScreenUtil().setSp(15),
        ),
      ),
      ListTile(
        title: Text(
          widget.item.description,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(14)),
        ),
        leading: Icon(
          Icons.text_fields,
          color: Theme.of(context).primaryColor,
        ),
      ),
    ]);
  }
}
