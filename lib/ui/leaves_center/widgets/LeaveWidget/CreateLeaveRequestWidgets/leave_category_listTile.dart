import 'package:erb_mobo/models/leaveCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveCategoryListTile extends StatefulWidget {
  final LeaveCategory item;
  final bool isSelected;
  const LeaveCategoryListTile({
    Key? key,
    required this.item,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<LeaveCategoryListTile> createState() => _LeaveCategoryListTileState();
}

class _LeaveCategoryListTileState extends State<LeaveCategoryListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          widget.item.name,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(14)),
        ),
        subtitle:
            Text('deduction amount :' + widget.item.deductionAmount.toString()),
        leading: Icon(
          Icons.category_outlined,
          color: Theme.of(context).primaryColor,
        ),
        trailing: widget.isSelected
            ? Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
                size: ScreenUtil().setSp(20),
              )
            : Icon(
                Icons.check_circle,
                color: Colors.grey,
                size: ScreenUtil().setSp(20),
              ));
  }
}
