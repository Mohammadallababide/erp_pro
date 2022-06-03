import 'package:erb_mobo/ui/invoices-center/widgets/invoice_Action_Button_widgets/users_list_dialog_for_InvoiceAssignment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/invoice.dart';
import '../../../../models/user.dart';
import '../../../users List/bloc/users_bloc.dart';
import '../../bloc/invoice_bloc.dart';
import '../../pages/invoice_details_page.dart';
import '../enum/inv_filter_type_enum.dart';

class InvoiceActionOptionsOnInvoiceStatus extends StatefulWidget {
  final Invoice inv;
  final InvoiceBloc invoiceBloc;
  final bool isFromInvoiceDetailsPage;

  InvoiceActionOptionsOnInvoiceStatus({
    Key? key,
    required this.inv,
    required this.invoiceBloc,
    required this.isFromInvoiceDetailsPage,
  }) : super(key: key);

  @override
  State<InvoiceActionOptionsOnInvoiceStatus> createState() =>
      _InvoiceActionOptionsOnInvoiceStatusState();
}

class _InvoiceActionOptionsOnInvoiceStatusState
    extends State<InvoiceActionOptionsOnInvoiceStatus> {
  late User? userAssignemt = widget.inv.assignee;

  void listenToAssignOrUnAssignAction(User? userAssign) {
    if (userAssign != null) {
      userAssignemt = userAssign;
    } else {
      setState(() {
        userAssignemt = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: buildInvoiceActionOptionsOnInvoiceStatus(context),
    );
  }

  List<Widget> buildInvoiceActionOptionsOnInvoiceStatus(BuildContext context) {
    late List<Widget> options = [];
    // for review pending invoice status ...
    options.add(
      Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(15),
              ),
              child: Text(
                "invoice Action list :",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(20)),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(15),
          ),
        ],
      ),
    );
    if (!widget.isFromInvoiceDetailsPage) {
      options.add(
        optionCardItem(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IvoiceDtailsPage(
                  inv: widget.inv,
                ),
              ),
            );
          },
          optionIcon: Icon(
            Icons.more,
            color: Colors.indigo,
          ),
          optionSubTile:
              'go to the invoice details page to show all the invoice content.',
          optionTile: 'invoice details',
        ),
      );
    }

    options.add(UsersListDialogForInvoicesAssignment(
      invId: widget.inv.id!,
      invoiceBloc: widget.invoiceBloc,
      userActionCallBack: listenToAssignOrUnAssignAction,
      userAssignemt: userAssignemt,
    ));

    if (widget.inv.status ==
            InvFilterTypeEnum.review_pending.toString().split('.')[1]
        //  &&widget.isFromInvoiceDetailsPage
        ) {
      options.add(
        optionCardItem(
          onTap: () {
            widget.invoiceBloc.add(ReviewInvoice(widget.inv.id!));
            Navigator.pop(context);
          },
          optionIcon: Icon(
            Icons.visibility,
            color: Colors.grey,
          ),
          optionSubTile:
              'confirm review invoice that mean that you already seen the content of this invoice.',
          optionTile: 'confirm review invoice',
        ),
      );
    }
    // for approve pending invoice status ...
    if (widget.inv.status ==
        InvFilterTypeEnum.approval_pending.toString().split('.')[1]) {
      options.add(
        optionCardItem(
          onTap: () {
            widget.invoiceBloc.add(ApproveInvoice(widget.inv.id!));
            Navigator.pop(context);
          },
          optionIcon: Icon(
            Icons.check_circle,
            color: Colors.greenAccent,
          ),
          optionSubTile: 'you can approve the contanet of this invoice .',
          optionTile: 'approve invoice',
        ),
      );
    }
    // for payment pending invoice status ...
    if (widget.inv.status ==
        InvFilterTypeEnum.payment_pending.toString().split('.')[1]) {
      options.add(
        optionCardItem(
          onTap: () {
            widget.invoiceBloc.add(MarkAsPaidInvoice(widget.inv.id!));
            Navigator.pop(context);
          },
          optionIcon: Icon(
            Icons.monetization_on_rounded,
            color: Colors.amberAccent,
          ),
          optionSubTile:
              'the invoice status will be complated after mark as paid.',
          optionTile: 'mark as Paid',
        ),
      );
    }
    if (widget.inv.status !=
            InvFilterTypeEnum.completed.toString().split('.')[1] &&
        widget.inv.status !=
            InvFilterTypeEnum.failed.toString().split('.')[1] &&
        widget.inv.status !=
            InvFilterTypeEnum.rejected.toString().split('.')[1]) {
      options.add(
        optionCardItem(
          onTap: () {
            widget.invoiceBloc.add(RejectInvoice(widget.inv.id!));
            Navigator.pop(context);
          },
          optionIcon: Icon(
            Icons.close_sharp,
            color: Colors.redAccent,
          ),
          optionSubTile: 'you can reject the contanet of this invoice .',
          optionTile: 'reject invoice',
        ),
      );
    } else {
      options.add(
        optionCardItem(
          onTap: () {
            widget.invoiceBloc.add(DeleteInvoice(widget.inv.id!));
            Navigator.pop(context);
          },
          optionIcon: Icon(
            Icons.delete,
            color: Colors.redAccent,
          ),
          optionSubTile: 'you can delete this invoice .',
          optionTile: 'delete invoice',
        ),
      );
    }

    return options;
  }

  InkWell optionCardItem({
    required void Function()? onTap,
    required optionTile,
    required optionSubTile,
    required Widget optionIcon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: ListTile(
            title: Text(
              optionTile,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(14)),
            ),
            subtitle: Text(optionSubTile),
            trailing: optionIcon),
      ),
    );
  }
}
