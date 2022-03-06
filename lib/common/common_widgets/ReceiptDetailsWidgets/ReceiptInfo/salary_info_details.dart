import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../models/receipt.dart';

class SalaryInfoDetails extends StatelessWidget {
  final Receipt receiptDetails;
  final bool isMyReceipt;
  const SalaryInfoDetails({
    Key? key,
    required this.receiptDetails,
    required this.isMyReceipt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setWidth(15),
        horizontal: ScreenUtil().setWidth(20),
      ),
      children: [
        isMyReceipt
            ? Column(
                children: [
                  buildReceiptUserAsignment(context),
                  SizedBox(
                    height: ScreenUtil().setHeight(25),
                  ),
                ],
              )
            : Container(),
        buildSalaryDetailsContaint(context),
        Align(
            alignment: Alignment.centerLeft,
            child: calculateTotalSalar(context)),
      ],
    );
  }

  Widget buildSalaryDetailsContaint(BuildContext context) {
    return Column(children: [
      buildReceiptDateDetails(context),
      SizedBox(
        height: ScreenUtil().setHeight(25),
      ),
      buildSalaryDetails(
          receiptDetails.salary.amount.toString(), 'Salary amount :', context),
      buildSalaryDetails(
          receiptDetails.salary.bonus.toString(), 'bonus on salary :', context),
      buildSalaryDetails(receiptDetails.salary.allowance.toString(),
          'allowance amount :', context),
    ]);
  }

  Widget buildReceiptUserAsignment(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Salary Asignment to :',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Icon(
              Icons.account_circle,
              color: Theme.of(context).primaryColor,
              size: ScreenUtil().setSp(25),
            )
          ],
        ),
        SizedBox(
          height: ScreenUtil().setHeight(15),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Container(
                height: ScreenUtil().setSp(25),
                width: ScreenUtil().setSp(25),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Image(
                  image: AssetImage('assets/images/useric.png'),
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(7),
              ),
              Text(
                receiptDetails.user.firstName +
                    ' ' +
                    receiptDetails.user.lastName,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        buildCusDividorLine(context),
      ],
    );
  }

  Widget buildReceiptDateDetails(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Salary Date info :',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Icon(
              Icons.date_range,
              color: Theme.of(context).primaryColor,
              size: ScreenUtil().setSp(25),
            )
          ],
        ),
        SizedBox(
          height: ScreenUtil().setHeight(15),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'From ${receiptDetails.salary.workStartDate}',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(14),
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              'To ${receiptDetails.salary.workEndDate}',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(14),
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
        buildCusDividorLine(context),
      ],
    );
  }

  Widget buildCusDividorLine(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(30),
      height: ScreenUtil().setHeight(20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget calculateTotalSalar(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Total Salary :',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.w700,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(15),
        ),
        buildTermCalucationOfTotalSalary(
          context: context,
          title: 'Salary after calculate bonus and allowance :',
          value: receiptDetails.salary.amount +
              receiptDetails.salary.bonus +
              receiptDetails.salary.allowance,
        ),
        const Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.remove_circle,
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(15),
        ),
        buildTermCalucationOfTotalSalary(
          context: context,
          title: 'Total deductions :',
          value: calculateTotalDeducionsValue(receiptDetails),
        ),
        buildCusDividorLine(context),
        SizedBox(
          height: ScreenUtil().setHeight(15),
        ),
        buildTermCalucationOfTotalSalary(
          context: context,
          title: 'Result :',
          value: 230,
        ),
      ],
    );
  }

  int calculateTotalSalarValue(Receipt receipt) {
    return (receipt.salary.amount +
            receipt.salary.bonus +
            receipt.salary.allowance) -
        calculateTotalDeducionsValue(receipt);
  }

  int calculateTotalDeducionsValue(Receipt receipt) {
    int totalDedection = 0;
    for (int i = 0; i < receipt.deductions.length; i++) {
      totalDedection = totalDedection + receipt.deductions[i].amount as int;
    }
    return totalDedection;
  }

  Widget buildTermCalucationOfTotalSalary({
    required BuildContext context,
    required String title,
    required int value,
  }) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            title,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(14),
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            value.toString(),
            style: TextStyle(
              fontSize: ScreenUtil().setSp(14),
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSalaryDetails(
          String getValue, String title, BuildContext context) =>
      Padding(
        padding: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    getValue,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      height: ScreenUtil().setHeight(1.5),
                    ),
                  ),
                ),
                Icon(
                  Icons.attach_money_outlined,
                  color: Theme.of(context).primaryColor,
                  size: ScreenUtil().setSp(27),
                )
              ],
            ),
            buildCusDividorLine(context),
          ],
        ),
      );
}
