import 'package:erb_mobo/models/leaveCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/common_widgets/commonDialog/confirm_process_Dialog.dart';
import '../../../../../core/utils/app_snack_bar.dart';
import '../../../bloc/leave_center_bloc.dart';

class LeaveCategoryCard extends StatefulWidget {
  final LeaveCategory leaveCategory;
  final int index;
  final Function deletingActionCallBack;
  LeaveCategoryCard({
    Key? key,
    required this.leaveCategory,
    required this.index,
    required this.deletingActionCallBack,
  }) : super(key: key);

  @override
  State<LeaveCategoryCard> createState() => _LeaveCategoryCardState();
}

class _LeaveCategoryCardState extends State<LeaveCategoryCard> {
  final LeaveCenterBloc leaveCenterBloc = LeaveCenterBloc();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: leaveCenterBloc,
      listener: (context, state) {
        if (state is ErrorDelettedLeaveCategory) {
          ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
              message: 'Faild Deletting leave category !', context: context));
        } else if (state is SuccessDelettedLeaveCategory) {
          setState(() {
            widget.deletingActionCallBack(widget.index);
          });
        }
      },
      child: Container(
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
                horizontal: ScreenUtil().setWidth(15),
                vertical: ScreenUtil().setHeight(10),
              ),
              child: contentOfTheCard(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget contentOfTheCard(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.category,
              color: Theme.of(context).primaryColor,
              size: ScreenUtil().setSp(22),
            ),
            BlocBuilder(
              bloc: leaveCenterBloc,
              builder: (context, state) {
                if (state is DelettingLeaveCategory) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircularProgressIndicator(
                      color: Colors.red,
                      strokeWidth: ScreenUtil().setWidth(3),
                    ),
                  );
                }
                return IconButton(
                  onPressed: () => showConfeirmProcessAlert(
                    context: context,
                    cancelProcessFun: () {
                      Navigator.of(context).pop();
                    },
                    submitProcessFun: () {
                      Navigator.of(context).pop();
                      leaveCenterBloc
                          .add(DeleteLeaveCategory(widget.leaveCategory.id));
                    },
                    prcessedText:
                        "Are You Sure Want To Delete this Leave Category ?",
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: ScreenUtil().setSp(22),
                  ),
                );
              },
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Name :',
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: ScreenUtil().setWidth(10)),
            Text(
              widget.leaveCategory.name!,
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtil().setHeight(12),
        ),
        Row(
          children: [
            Text(
              'Deduction Amount :',
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: ScreenUtil().setWidth(10)),
            Text(
              widget.leaveCategory.deductionAmount.toString() + '\$',
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
