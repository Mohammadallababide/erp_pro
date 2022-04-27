import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/theme_helper.dart';
import '../../../../core/utils/core_util_function.dart';
import '../../../../models/invoice.dart';

class InvTableFunc {
  static DataRow invoiceTableRow({
    required Invoice inv,
    required Function onTapFunc,
    required BuildContext context,
  }) {
    return DataRow(cells: [
      // for invoice name or id
      DataCell(
        Center(
          child: Text('# ${inv.id}'),
        ),
      ),
      // for invoice submited by info
      DataCell(
        Center(
          child: Text(inv.submittedBy != null
              ? inv.submittedBy!.firstName + ' ' + inv.submittedBy!.lastName
              : '...'),
        ),
      ),
      // for invoice status info
      DataCell(
        Center(
          child: Text(
            inv.status,
          ),
        ),
      ),
      // for invoice due date info
      DataCell(
        Center(
          child: Text(
            CorerUtilFunction.getFormalDate(inv.dueDate),
          ),
        ),
      ),
      // for invoice gross amount info
      DataCell(
        Center(
          child: Text(inv.grossAmount.toString()),
        ),
      ),
      // for invoice action
      DataCell(
        Center(
          child: buildActionButton(context, onTapFunc),
        ),
      ),
    ]);
  }

  static List<DataColumn> invoiceTableColumn() {
    List<DataColumn> result = [
      DataColumn(
        label: Text(
          'invoice',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(15),
          ),
        ),
      ),
      DataColumn(
          label: Text(
        'submittedBy',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setSp(15),
        ),
      )),
      DataColumn(
          label: Text(
        'status',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setSp(15),
        ),
      )),
      DataColumn(
          label: Text(
        'dueDate',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setSp(15),
        ),
      )),
      DataColumn(
          label: Text(
        'invoiceTotal',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setSp(15),
        ),
      )),
      DataColumn(
          label: Text(
        'Action',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setSp(15),
        ),
      )),
    ];
    return result;
  }

  static Widget buildActionButton(BuildContext context, onTapFunc) {
    return InkWell(
      onTap: onTapFunc,
      child: Container(
        height: ScreenUtil().setHeight(28),
        width: ScreenUtil().setWidth(55),
        decoration: ThemeHelper().buttonBoxDecoration(context: context),
        child: Center(
          child: Text(
            'Actions',
            style: GoogleFonts.belleza(
              fontStyle: FontStyle.normal,
              textStyle: TextStyle(
                fontSize: ScreenUtil().setSp(12),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
