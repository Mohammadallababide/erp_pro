import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/theme_helper.dart';
import '../../../models/invoice.dart';
import '../pages/invoice_details_page.dart';
import 'enum/inv_filter_type_enum.dart';
import 'inv_table_widgets/inv_table_func.dart';

class InvFilter extends StatelessWidget {
  final List<Invoice> invoiceList;
  final InvFilterTypeEnum filterType;
  const InvFilter(
      {Key? key, required this.invoiceList, required this.filterType})
      : super(key: key);

  List<Invoice> getFilteredInvs() {
    List<Invoice> res = [];
    if (filterType == InvFilterTypeEnum.review_pending) {
      invoiceList.forEach((element) {
        if (element.status ==
            InvFilterTypeEnum.review_pending.toString().split('.')[1]) {
          res.add(element);
        }
      });
    } else if (filterType == InvFilterTypeEnum.payment_pending) {
      invoiceList.forEach((element) {
        if (element.status ==
            InvFilterTypeEnum.payment_pending.toString().split('.')[1]) {
          res.add(element);
        }
      });
    } else if (filterType == InvFilterTypeEnum.approval_pending) {
      invoiceList.forEach((element) {
        if (element.status ==
            InvFilterTypeEnum.approval_pending.toString().split('.')[1]) {
          res.add(element);
        }
      });
    }
    // for all filter type
    else {
      res = invoiceList;
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Theme(
          data: Theme.of(context),
          //     .copyWith(dividerColor: Theme.of(context).primaryColorDark),
          child: DataTable(
            dividerThickness: 1.5,
            showBottomBorder: true,
            columns: InvTableFunc.invoiceTableColumn(),
            rows: getDataTableRowList(context),
          ),
        ),
      ),
    ]);
  }

  List<DataRow> getDataTableRowList(BuildContext context) {
    List<DataRow> res = [];
    getFilteredInvs().forEach((element) {
      res.add(
        InvTableFunc.invoiceTableRow(
            inv: element,
            context: context,
            onTapFunc: () => showActionInvoiceDialog(context, element)),
      );
    });
    return res;
  }
}

Future<void> showActionInvoiceDialog(
  BuildContext context,
  Invoice inv,
) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            height: ScreenUtil().setHeight(200),
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(25),
                vertical: ScreenUtil().setHeight(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(5),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Ivoice Action:",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(20)),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      decoration:
                          ThemeHelper().buttonBoxDecoration(context: context),
                      child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          child: Center(
                            child: Text(
                              'Review'.toUpperCase(),
                              style: GoogleFonts.belleza(
                                fontStyle: FontStyle.normal,
                                textStyle: TextStyle(
                                  fontSize: ScreenUtil().setSp(20),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IvoiceDtailsPage(
                                  inv: inv,
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                    Container(
                      decoration:
                          ThemeHelper().buttonBoxDecoration(context: context),
                      child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          child: Center(
                            child: Text(
                              'Assign'.toUpperCase(),
                              style: GoogleFonts.belleza(
                                fontStyle: FontStyle.normal,
                                textStyle: TextStyle(
                                  fontSize: ScreenUtil().setSp(20),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () => {}),
                    ),
                  ],
                ),
                Container(),
              ],
            ),
          ),
        );
      });
}
