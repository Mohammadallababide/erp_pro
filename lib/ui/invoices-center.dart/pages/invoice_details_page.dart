import 'package:erb_mobo/common/common_widgets/commomn_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../core/utils/core_util_function.dart';
import '../../../models/invoice.dart';
import '../../../models/user.dart';

class IvoiceDtailsPage extends StatefulWidget {
  final Invoice inv;
  const IvoiceDtailsPage({Key? key, required this.inv}) : super(key: key);

  @override
  State<IvoiceDtailsPage> createState() => _IvoiceDtailsPageState();
}

class _IvoiceDtailsPageState extends State<IvoiceDtailsPage> {
  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(
          title: 'Ivoice Details',
          context: context,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Center(
            child: Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ),
          onPressed: () => showMoreInvoiceInfo(context, widget.inv),
        ),
        body: ListView(
          children: [
            Container(
              height: ScreenUtil().setHeight(270),
              width: double.infinity,
              child: SfPdfViewer.asset(
                'assets/uploadFiles/inv.pdf',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(15),
                vertical: ScreenUtil().setHeight(10),
              ),
              child: Column(
                children: [
                  buildSectionCardRelatedToUser(
                      context: context,
                      title: 'Invoice submited by :',
                      user: widget.inv.submittedBy),
                  buildInvoiceInfoCard(
                    context: context,
                    title: 'due date',
                    getValue:
                        CorerUtilFunction.getFormalDate(widget.inv.dueDate),
                  ),
                  buildInvoiceInfoCard(
                    context: context,
                    title: 'created date',
                    getValue:
                        CorerUtilFunction.getFormalDate(widget.inv.issueDate),
                  ),
                  buildInvoiceInfoCard(
                    context: context,
                    title: 'gross amount',
                    getValue: widget.inv.grossAmount.toString(),
                  ),
                  buildInvoiceInfoCard(
                    context: context,
                    title: 'net amount',
                    getValue: widget.inv.netAmount.toString(),
                  ),
                  buildInvoiceInfoCard(
                    context: context,
                    title: 'tax number',
                    getValue: widget.inv.taxNumber,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  /// [buildSectionCardRelatedToUser] represent to show invoice info card related to user like [submited by , reviwed by , payment by ,...]

  Widget buildSectionCardRelatedToUser({
    required BuildContext context,
    required String title,
    User? user,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
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
            child: user == null
                ? Text(
                    'not selected yet',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.w500),
                  )
                : Row(
                    children: [
                      Container(
                        height: ScreenUtil().setSp(25),
                        width: ScreenUtil().setSp(25),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2),
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
                        user.firstName + ' ' + user.lastName,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
          ),
          buildCusDividorLine(context),
        ],
      ),
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

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildInvoiceInfoCard({
    required String getValue,
    required String title,
    required BuildContext context,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(15),
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
            const SizedBox(
              height: 1,
            ),
            Container(
              width:
                  MediaQuery.of(context).size.width - ScreenUtil().setWidth(30),
              height: ScreenUtil().setHeight(38),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1.5,
                  ),
                ),
              ),
              child: Text(
                getValue,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(15),
                  height: ScreenUtil().setHeight(1.5),
                ),
              ),
            )
          ],
        ),
      );
  Future<void> showMoreInvoiceInfo(
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
              height: ScreenUtil().setHeight(420),
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(25),
                  vertical: ScreenUtil().setHeight(10)),
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "More invoice info:",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(20)),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  Column(
                    children: [
                      buildSectionCardRelatedToUser(
                          context: context,
                          title: 'Invoice reviewed by :',
                          user: widget.inv.reviewedBy),
                      buildSectionCardRelatedToUser(
                          context: context,
                          title: 'Invoice paid by :',
                          user: widget.inv.paidBy),
                      buildSectionCardRelatedToUser(
                          context: context,
                          title: 'Invoice approved by :',
                          user: widget.inv.approvedBy),
                      buildSectionCardRelatedToUser(
                          context: context,
                          title: 'Invoice rejected by :',
                          user: widget.inv.rejectedBy),
                    ],
                  ),
                  Container(),
                ],
              ),
            ),
          );
        });
  }
}
