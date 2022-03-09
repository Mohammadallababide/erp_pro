import 'package:erb_mobo/models/receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../ui/users_finacial_mange/bloc/usersfinaicalmange_bloc.dart';
import '../../../ui/users_finacial_mange/pages/create_or_edit_receipt_page.dart';
import '../app_snack_bar.dart';
import '../commonDialog/confirm_process_Dialog.dart';
import 'ReceiptInfo/deductions_info_list.dart';
import 'ReceiptInfo/salary_info_details.dart';

class ReceiptDetails extends StatefulWidget {
  final Receipt receipt;
  final bool isMyReceipt;
  final Function? editInReceiptsListCallBack;
  final Function? deleteReceiptCallBack;

  const ReceiptDetails({
    Key? key,
    required this.receipt,
    required this.isMyReceipt,
    this.editInReceiptsListCallBack,
    this.deleteReceiptCallBack,
  }) : super(key: key);

  @override
  State<ReceiptDetails> createState() => _ReceiptDetailsState();
}

class _ReceiptDetailsState extends State<ReceiptDetails> {
  final UsersfinaicalmangeBloc receiptBloc = UsersfinaicalmangeBloc();

  late Receipt receiptDetail;
  @override
  void initState() {
    super.initState();
    receiptDetail = widget.receipt;
  }

  void listenToReceiptEditAction(Receipt newValue) {
    setState(() {
      receiptDetail = newValue;
      widget.editInReceiptsListCallBack!(newValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: receiptBloc,
      listener: (context, state) {
        if (state is SuccessDeletingReceipt) {
          setState(() {
            widget.deleteReceiptCallBack!(widget.receipt.id);
          });
          Navigator.pop(context);
        } else if (state is ErrorDeletingReceipt) {
          ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
              message: 'Faild Delete Receipt !', context: context));
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Receipt Details',
              style: TextStyle(color: Colors.white),
            ),
            actions: widget.isMyReceipt
                ? [
                    BlocBuilder(
                      bloc: receiptBloc,
                      builder: (context, state) {
                        if (state is DeletingReceipt) {
                          return SizedBox(
                            height: ScreenUtil().setWidth(25),
                            width: ScreenUtil().setWidth(25),
                            child: CircularProgressIndicator(
                              color: Colors.red,
                              strokeWidth: ScreenUtil().setWidth(3),
                            ),
                          );
                        }
                        return IconButton(
                          onPressed: () => showConfeirmProcessAlert(
                            context: context,
                            cancelProcessFun: () {
                              Navigator.of(context).pop();
                            },
                            submitProcessFun: () {
                              Navigator.of(context).pop();
                              receiptBloc.add(
                                DeleteReceipt(widget.receipt.id!),
                              );
                            },
                            prcessedText:
                                "Are You Sure Want To Delete this Receipt?",
                          ),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          highlightColor: Colors.red,
                          iconSize: ScreenUtil().setSp(25),
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateOrEditUserReceiptPage(
                              receipt: receiptDetail,
                              receiptId: receiptDetail.id,
                              editReceiptInfoCallBack:
                                  listenToReceiptEditAction,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      highlightColor: Colors.black54,
                      iconSize: ScreenUtil().setSp(25),
                    )
                  ]
                : [],
            elevation: 0.0,
            backgroundColor: Theme.of(context).primaryColor,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            bottom: PreferredSize(
              preferredSize: Size(
                0,
                ScreenUtil().setHeight(60),
              ),
              child: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.attach_money_outlined),
                    text: 'Salary Info',
                  ),
                  Tab(
                    icon: Icon(Icons.money_off_sharp),
                    text: 'deductions info',
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              SalaryInfoDetails(
                receiptDetails: receiptDetail,
                isMyReceipt: widget.isMyReceipt,
              ),
              DeductionsInfoList(
                deductionList: receiptDetail.deductions,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
