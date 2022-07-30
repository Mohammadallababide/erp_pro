import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/costant.dart';
import '../../../../models/invoice.dart';
import '../../bloc/invoice_bloc.dart';
import 'Invoice_action_button_listener.dart';
import 'invoice_action_option_on_invoice_status.dart';

class InvoiceActionButton extends StatelessWidget {
  final Invoice inv;
  final Widget? childWidget;
  final bool isFromInvoiceDetailsPage;
  final Function invoiceActionCallBack;
  final InvoiceBloc invoiceBloc = InvoiceBloc();
  InvoiceActionButton({
    Key? key,
    required this.inv,
    this.childWidget,
    required this.isFromInvoiceDetailsPage,
    required this.invoiceActionCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return IvoiceActionButtonListner(
      invoiceBloc: invoiceBloc,
      isFromInvoiceDetailsPage: isFromInvoiceDetailsPage,
      invoiceActionCallBack: invoiceActionCallBack,
      childWidget: BlocBuilder(
        bloc: invoiceBloc,
        builder: (context, state) {
          if (state is DelettingInvoice ||
              state is RejecttingInvoice ||
              state is UnAssigningInvoiceToUser) {
            return CircularProgressIndicator(
              color: Colors.redAccent,
              strokeWidth: ScreenUtil().setWidth(3),
            );
          } else if (state is ReviewingInvoice) {
            return CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
              strokeWidth: ScreenUtil().setWidth(3),
            );
          } else if (state is ApprovingInvoice) {
            return CircularProgressIndicator(
              color: Colors.greenAccent,
              strokeWidth: ScreenUtil().setWidth(3),
            );
          } else if (state is MarkAsPaidingInvoice) {
            return CircularProgressIndicator(
              color: Colors.amberAccent,
              strokeWidth: ScreenUtil().setWidth(3),
            );
          } else if (state is AssigningInvoiceToUser) {
            return CircularProgressIndicator(
              color: Colors.blueAccent,
              strokeWidth: ScreenUtil().setWidth(3),
            );
          }

          return childWidget == null
              ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: ConstatValues.secGradientColor,
                  ),
                  child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    heroTag: null,
                    child: Center(
                      child: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => showInvoiceActionList(context),
                  ),
                )
              : InkWell(
                  child: childWidget,
                  onTap: () => showInvoiceActionList(context),
                );
        },
      ),
    );
  }

  Future<void> showInvoiceActionList(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              // height: ScreenUtil().setHeight(320),
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(5),
                  vertical: ScreenUtil().setHeight(15)),
              child: InvoiceActionOptionsOnInvoiceStatus(
                inv: inv,
                invoiceBloc: invoiceBloc,
                isFromInvoiceDetailsPage: isFromInvoiceDetailsPage,
              ),
            ),
          );
        });
  }
}
