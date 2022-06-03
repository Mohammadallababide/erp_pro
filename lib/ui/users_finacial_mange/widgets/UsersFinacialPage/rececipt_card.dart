import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../models/receipt.dart';
import 'ReceiptCardWidgets/asigment_user_section_for_SalaryCard.dart';
import 'ReceiptCardWidgets/number_and_dateRange_section_for_SalaryCard.dart';
import 'ReceiptCardWidgets/total_salary_section_for_salaryCard.dart';

class RececiptCard extends StatelessWidget {
  final Receipt receipt;
  final int index;
  final Widget detailsButton;
  const RececiptCard({
    Key? key,
    required this.receipt,
    required this.index,
    required this.detailsButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              vertical: ScreenUtil().setHeight(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NumberAndDateRangeSectionForSalaryCard(
                    receipt: receipt, index: index),
                SizedBox(
                  height: ScreenUtil().setHeight(8),
                ),
                AsigmentUserSectionForSalaryCard(
                  receipt: receipt,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                TotalSalarySectionForSalaryCard(receipt: receipt),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                detailsButton
              ],
            ),
          ),
        ),
      ),
    );
  }
}
