import 'package:erb_mobo/models/receipt.dart';
import 'package:erb_mobo/ui/my_profile/widgets/ReceiptDetailsWidgets/ReceiptInfo/salary_info_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ReceiptInfo/deductions_info_list.dart';

class ReceiptDetails extends StatefulWidget {
  final Receipt receipt;
  const ReceiptDetails({Key? key, required this.receipt}) : super(key: key);

  @override
  State<ReceiptDetails> createState() => _ReceiptDetailsState();
}

class _ReceiptDetailsState extends State<ReceiptDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Receipt Details',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          bottom: PreferredSize(
            preferredSize: Size(
              0,
              ScreenUtil().setHeight(60),
            ),
            child: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.attach_money_outlined),
                  text: 'Salary Info',
                ),
                Tab(
                  icon: Icon(Icons.money_off_sharp),
                  text: 'deductions info',
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SalaryInfoDetails(salaryDetails: widget.receipt.salary),
            DeductionsInfoList(
              deductionList: widget.receipt.deductions,
            ),
          ],
        ),
      ),
    );
  }
}
