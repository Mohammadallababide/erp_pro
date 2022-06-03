import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/theme_helper.dart';
import '../../../core/utils/core_util_function.dart';
import '../../../models/invoice.dart';
import '../bloc/invoice_bloc.dart';
import 'enum/inv_filter_type_enum.dart';
import 'invoice_Action_Button_widgets/invoice_action_button.dart';

class InvFilter extends StatefulWidget {
  final List<Invoice> invoiceList;
  final InvoiceBloc invBloc;

  final InvFilterTypeEnum filterType;
  const InvFilter(
      {Key? key,
      required this.invoiceList,
      required this.filterType,
      required this.invBloc})
      : super(key: key);

  @override
  State<InvFilter> createState() => _InvFilterState();
}

class _InvFilterState extends State<InvFilter> {
  late List<Invoice> invoiceReviewPanddingList = [];
  late List<Invoice> invoiceApprovePanddingList = [];
  late List<Invoice> invoicePayementPanddingList = [];
  late List<Invoice> invoiceReviewList = [];
  late InvFilterTypeEnum filterTypeChangable = widget.filterType;
  @override
  void initState() {
    super.initState();
    intiFilteredInvs();
  }

  void listToActionOnInvoice() {
    widget.invBloc.add(GetInvoices());
  }

  void intiFilteredInvs() {
    if (filterTypeChangable == InvFilterTypeEnum.review_pending) {
      widget.invoiceList.forEach((element) {
        if (element.status ==
            InvFilterTypeEnum.review_pending.toString().split('.')[1]) {
          invoiceReviewPanddingList.add(element);
        }
      });
    } else if (filterTypeChangable == InvFilterTypeEnum.payment_pending) {
      widget.invoiceList.forEach((element) {
        if (element.status ==
            InvFilterTypeEnum.payment_pending.toString().split('.')[1]) {
          invoicePayementPanddingList.add(element);
        }
      });
    } else if (filterTypeChangable == InvFilterTypeEnum.approval_pending) {
      widget.invoiceList.forEach((element) {
        if (element.status ==
            InvFilterTypeEnum.approval_pending.toString().split('.')[1]) {
          invoiceApprovePanddingList.add(element);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Theme(
          data: Theme.of(context),
          child: DataTable(
            dividerThickness: 1.5,
            showBottomBorder: true,
            columns: invoiceTableColumn(),
            rows: getDataTableRowList(context),
          ),
        ),
      ),
    ]);
  }

  List<DataRow> getDataTableRowList(BuildContext context) {
    List<DataRow> res = [];
    filterTypeChangable == InvFilterTypeEnum.review_pending
        ? invoiceReviewPanddingList.forEach((element) {
            res.add(
              invoiceTableRow(
                inv: element,
                context: context,
              ),
            );
          })
        : filterTypeChangable == InvFilterTypeEnum.approval_pending
            ? invoiceApprovePanddingList.forEach((element) {
                res.add(
                  invoiceTableRow(
                    inv: element,
                    context: context,
                  ),
                );
              })
            : filterTypeChangable == InvFilterTypeEnum.payment_pending
                ? invoicePayementPanddingList.forEach((element) {
                    res.add(
                      invoiceTableRow(
                        inv: element,
                        context: context,
                      ),
                    );
                  })
                : widget.invoiceList.forEach((element) {
                    res.add(
                      invoiceTableRow(
                        inv: element,
                        context: context,
                      ),
                    );
                  });
    return res;
  }

  DataRow invoiceTableRow({
    required Invoice inv,
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
          child: InvoiceActionButton(
            inv: inv,
            childWidget: buildActionButton(context),
            isFromInvoiceDetailsPage: false,
            invoiceActionCallBack: listToActionOnInvoice,
          ),
        ),
      ),
    ]);
  }

  List<DataColumn> invoiceTableColumn() {
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

  Widget buildActionButton(BuildContext context) {
    return Container(
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
    );
  }
}
