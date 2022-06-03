import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_flash_bar.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../bloc/invoice_bloc.dart';

class IvoiceActionButtonListner extends StatefulWidget {
  final Widget childWidget;
  final Function invoiceActionCallBack;
  final InvoiceBloc invoiceBloc;
  final bool isFromInvoiceDetailsPage;
  const IvoiceActionButtonListner({
    Key? key,
    required this.childWidget,
    required this.invoiceActionCallBack,
    required this.invoiceBloc,
    required this.isFromInvoiceDetailsPage,
  }) : super(key: key);

  @override
  State<IvoiceActionButtonListner> createState() =>
      _IvoiceActionButtonListnerState();
}

class _IvoiceActionButtonListnerState extends State<IvoiceActionButtonListner> {
  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: widget.invoiceBloc,
        listener: (context, state) {
          if (state is ErrorDelettedInvoice) {
            getAppSnackBar(
              context: context,
              message: 'Faild Detting Invoice',
            );
          } else if (state is ErrorApprovedInvoice) {
            getAppSnackBar(
              context: context,
              message: 'Faild Approved Invoice',
            );
          } else if (state is ErrorReviewedInvoice) {
            getAppSnackBar(
              context: context,
              message: 'Faild Confiem Reviewing Invoice',
            );
          } else if (state is ErrorRejectedInvoice) {
            getAppSnackBar(
              context: context,
              message: 'Faild Rejected Invoice',
            );
          } else if (state is ErrorAssignedInvoiceToUser) {
            getAppSnackBar(
              context: context,
              message: 'Faild Assign Invoice To User',
            );
          } else if (state is ErrorUnAssignedInvoiceToUser) {
            getAppSnackBar(
              context: context,
              message: 'Faild un Assign Invoice From User',
            );
          } else if (state is ErrorMarkAsPaidedInvoice) {
            getAppSnackBar(
              context: context,
              message: 'Faild Mark Invoice As Paided',
            );
          } else if (state is SuccessDelettedInvoice) {
            if (widget.isFromInvoiceDetailsPage) {
              Navigator.pop(context);
            } else if (!widget.isFromInvoiceDetailsPage) {
              setState(() {
                widget.invoiceActionCallBack();
              });
            }
            getFlashBar(
                context: context,
                title: 'Mission Success',
                message: 'the invoice has been deleted with success');
          } else if (state is SuccessApprovedInvoice) {
            getFlashBar(
              context: context,
              title: 'Mission Success',
              message: 'the invoice has been approved with success',
            );
            if (!widget.isFromInvoiceDetailsPage) {
              setState(() {
                widget.invoiceActionCallBack();
              });
            } else {
              setState(() {
                widget.invoiceActionCallBack(state.invoice);
              });
            }
          } else if (state is SuccessReviewedInvoice) {
            getFlashBar(
              context: context,
              title: 'Mission Success',
              message: 'the invoice has been confirmed Review with success',
            );
            if (!widget.isFromInvoiceDetailsPage) {
              setState(() {
                widget.invoiceActionCallBack();
              });
            } else {
              setState(() {
                widget.invoiceActionCallBack(state.invoice);
              });
            }
          } else if (state is SuccessRejectedInvoice) {
            getFlashBar(
              context: context,
              title: 'Mission Success',
              message: 'the invoice has been rejected with success',
            );
            if (!widget.isFromInvoiceDetailsPage) {
              setState(() {
                widget.invoiceActionCallBack();
              });
            } else {
              setState(() {
                widget.invoiceActionCallBack(state.invoice);
              });
            }
          } else if (state is SuccessMarkAsPaidedInvoice) {
            getFlashBar(
              context: context,
              title: 'Mission Success',
              message: 'the invoice has been marked as paid with success',
            );
            if (!widget.isFromInvoiceDetailsPage) {
              setState(() {
                widget.invoiceActionCallBack();
              });
            } else {
              setState(() {
                widget.invoiceActionCallBack(state.invoice);
              });
            }
          } else if (state is SuccessAssignedInvoiceToUser) {
            getFlashBar(
              context: context,
              title: 'Mission Success',
              message: 'the invoice has been assign with success To User',
            );
            if (!widget.isFromInvoiceDetailsPage) {
              setState(() {
                widget.invoiceActionCallBack();
              });
            } else {
              setState(() {
                widget.invoiceActionCallBack(state.invoice);
              });
            }
          } else if (state is SuccessUnAssignedInvoiceToUser) {
            getFlashBar(
              context: context,
              title: 'Mission Success',
              message: 'the invoice has been unAssign with success From User',
            );
            if (!widget.isFromInvoiceDetailsPage) {
              setState(() {
                widget.invoiceActionCallBack();
              });
            } else {
              setState(() {
                widget.invoiceActionCallBack(state.invoice);
              });
            }
          }
        },
        child: widget.childWidget);
  }
}
