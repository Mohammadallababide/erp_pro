import 'package:erb_mobo/models/receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../commonDialog/confirm_process_Dialog.dart';
import 'ReceiptInfo/deductions_info_list.dart';
import 'ReceiptInfo/salary_info_details.dart';

class ReceiptDetails extends StatefulWidget {
  final Receipt receipt;
  final bool isMyReceipt;
  const ReceiptDetails({
    Key? key,
    required this.receipt,
    required this.isMyReceipt,
  }) : super(key: key);

  @override
  State<ReceiptDetails> createState() => _ReceiptDetailsState();
}

class _ReceiptDetailsState extends State<ReceiptDetails> {
  // Todo use this function
  // bool isMyReceipt(){
  // if the userId of the user that saved in sharedpref is equal the userId of this receipt
  //so this user own this recepit.
  // return false;
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Receipt Details',
            style: TextStyle(color: Colors.white),
          ),
          actions: widget.isMyReceipt
              ? [
                  IconButton(
                    onPressed: () => showConfeirmProcessAlert(
                      context: context,
                      cancelProcessFun: () {
                        Navigator.of(context).pop();
                      },
                      submitProcessFun: () {},
                      prcessedText: "Are You Sure Want To Delete this Receipt?",
                    ),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    highlightColor: Colors.red,
                    iconSize: ScreenUtil().setSp(25),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    highlightColor: Colors.black54,
                    iconSize: ScreenUtil().setSp(25),
                  )
                ]
              : [],
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
            SalaryInfoDetails(
              salaryDetails: widget.receipt.salary,
              isMyReceipt: widget.isMyReceipt,
            ),
            DeductionsInfoList(
              deductionList: widget.receipt.deductions,
            ),
          ],
        ),
      ),
    );
  }
}
