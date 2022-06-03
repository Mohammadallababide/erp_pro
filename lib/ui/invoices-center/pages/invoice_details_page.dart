import 'package:erb_mobo/common/common_widgets/commomn_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../bloc/othBloc/bloc/common_app_bloc.dart';
import '../../../core/utils/core_util_function.dart';
import '../../../models/invoice.dart';
import '../widgets/invoice_Action_Button_widgets/invoice_action_button.dart';
import '../widgets/invoice_info_card.dart';
import '../widgets/more_inv_info_floatting_button.dart';
import '../widgets/section_card_related_to_user.dart';

class IvoiceDtailsPage extends StatefulWidget {
  final Invoice inv;
  const IvoiceDtailsPage({Key? key, required this.inv}) : super(key: key);

  @override
  State<IvoiceDtailsPage> createState() => _IvoiceDtailsPageState();
}

class _IvoiceDtailsPageState extends State<IvoiceDtailsPage> {
  late Invoice changableInv;
  CommonAppBloc commonAppBloc = CommonAppBloc();
  @override
  void initState() {
    changableInv = widget.inv;
    commonAppBloc.add(GetAppFile(changableInv.fileId!));
    super.initState();
  }

  void listToActionOnInvoice(Invoice invoice) {
    setState(() {
      changableInv = invoice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(
          title: 'Ivoice Details',
          context: context,
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InvoiceActionButton(
              inv: changableInv,
              isFromInvoiceDetailsPage: true,
              invoiceActionCallBack: listToActionOnInvoice,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(5),
            ),
            MoreInvInfoFloattingButton(inv: changableInv),
          ],
        ),
        body: BlocBuilder(
          bloc: commonAppBloc,
          builder: (context, state) {
            if (state is GettingAppFile) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            } else if (state is ErrorGettingAppFile) {
              return Center(
                child: Text('some thing is wrong'),
              );
            } else if (state is SuccessGetAppFile) {
              return ListView(
                children: [
                  Container(
                    height: ScreenUtil().setHeight(270),
                    width: double.infinity,
                    // child: SfPdfViewer.network(state.file.url),
                    child: SfPdfViewer.asset('assets/uploadFiles/inv.pdf'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(15),
                      vertical: ScreenUtil().setHeight(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScetionCardRelatedToUser(
                            title: 'Invoice submited by :',
                            userInfoRealted: changableInv.submittedBy),
                        ScetionCardRelatedToUser(
                            title: 'Invoice assignment to :',
                            userInfoRealted: changableInv.assignee),
                        InvoiceInfoCard(
                          title: 'due date',
                          getValue: CorerUtilFunction.getFormalDate(
                              changableInv.dueDate),
                        ),
                        InvoiceInfoCard(
                          title: 'created date',
                          getValue: CorerUtilFunction.getFormalDate(
                              changableInv.issueDate),
                        ),
                        InvoiceInfoCard(
                          title: 'gross amount',
                          getValue: changableInv.grossAmount.toString(),
                        ),
                        InvoiceInfoCard(
                          title: 'net amount',
                          getValue: changableInv.netAmount.toString(),
                        ),
                        InvoiceInfoCard(
                          title: 'tax number',
                          getValue: changableInv.taxNumber,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ));
  }
}
