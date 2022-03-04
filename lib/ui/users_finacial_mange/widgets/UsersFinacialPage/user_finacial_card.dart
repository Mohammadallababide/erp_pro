import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/common_widgets/ReceiptDetailsWidgets/receipt_details.dart';
import '../../../../common/theme_helper.dart';
import '../../../../models/deduction.dart';
import '../../../../models/receipt.dart';
import '../../../../models/salary.dart';

class UserFinacialCard extends StatelessWidget {
  const UserFinacialCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Receipt rec = Receipt(
      id: 1,
      userName: 'userNameT',
      deductions: [
        Deduction(amount: 10, reason: 'daily task ...', type: 'work deduction'),
        Deduction(amount: 10, reason: 'daily task ...', type: 'work deduction'),
        Deduction(amount: 10, reason: 'daily task ...', type: 'work deduction'),
      ],
      salary: Salary(
        id: 1,
        receiptId: 1,
        allowance: 200,
        amount: 100,
        bonus: 30,
        receiptName: 'receiptName',
      ),
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(5),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10),
                vertical: ScreenUtil().setHeight(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildNumberAndDateRangeSicationForSalaryCard(context),
                SizedBox(
                  height: ScreenUtil().setHeight(8),
                ),
                buildAsigmentUserSectionForSalaryCard(context),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                buildTotalSalarySectionForSalaryCard(context),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                buildDetailsButtonForSalaryCard(context, rec)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildNumberAndDateRangeSicationForSalaryCard(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: ScreenUtil().setHeight(15),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                ScreenUtil().setSp(150),
              ),
              child: Center(
                child: Text(
                  "#1",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Text(
              "From 5/5/2020 To 5/6/2020",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(5),
            ),
            Icon(
              Icons.date_range,
              size: ScreenUtil().setSp(15),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ],
    );
  }

  Align buildDetailsButtonForSalaryCard(
      BuildContext context, Receipt receiptDetails) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReceiptDetails(
                    receipt: receiptDetails, isMyReceipt: true)),
          );
        },
        child: Container(
          height: ScreenUtil().setHeight(40),
          width: ScreenUtil().setWidth(75),
          decoration: ThemeHelper().buttonBoxDecoration(context: context),
          child: Center(
            child: Text(
              'Details',
              style: GoogleFonts.belleza(
                fontStyle: FontStyle.normal,
                textStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column buildTotalSalarySectionForSalaryCard(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Total Salary :",
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(5),
          ),
          child: Row(
            children: [
              Text(
                "1500",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(2),
              ),
              Icon(
                Icons.attach_money_outlined,
                size: ScreenUtil().setSp(20),
              )
            ],
          ),
        ),
      ],
    );
  }

  Column buildAsigmentUserSectionForSalaryCard(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Salary To Asignment :",
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.bold),
          ),
        ),
        Row(
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
              "Mohammad Al lababidi",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
