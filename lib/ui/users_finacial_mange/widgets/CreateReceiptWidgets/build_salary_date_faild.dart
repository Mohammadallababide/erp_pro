import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class SlarayDateRangeFaild extends StatefulWidget {
  final String? startSalaryDate;
  final String? endSalaryDate;
  final String title;
  SlarayDateRangeFaild({
    this.startSalaryDate,
    this.endSalaryDate,
    required this.title,
  });

  @override
  _SlarayDateRangeFaildState createState() => _SlarayDateRangeFaildState();
}

class _SlarayDateRangeFaildState extends State<SlarayDateRangeFaild> {
  late String startSalaryDate;
  late String endSalaryDate;
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        startSalaryDate = DateFormat('dd/MM/yyyy').format(args.value.startDate);
        endSalaryDate = DateFormat('dd/MM/yyyy').format(args.value.endDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(15),
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(30),
          height: ScreenUtil().setHeight(38),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1.5,
              ),
            ),
          ),
          child: InkWell(
            onTap: () => _showSelectDateRangeForm(context),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'From ${widget.startSalaryDate} To ${widget.endSalaryDate} ',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      height: ScreenUtil().setHeight(1.5),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Theme.of(context).primaryColor,
                  size: ScreenUtil().setSp(20),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> _showSelectDateRangeForm(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SizedBox(
              height: ScreenUtil().setHeight(380),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(10),
                      top: ScreenUtil().setHeight(10),
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Salary Date Range :",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: ScreenUtil().setSp(20)),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  getDateRangePicker(),
                  Padding(
                     padding: EdgeInsets.only(
                      right: ScreenUtil().setWidth(10),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancal',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(15),
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget getDateRangePicker() {
    return SizedBox(
      child: Card(
        child: SfDateRangePicker(
          onSelectionChanged: _onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.range,
          initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 4)),
              DateTime.now().add(const Duration(days: 3))),
        ),
      ),
    );
  }
}
