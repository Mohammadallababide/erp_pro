import 'package:erb_mobo/models/receipt.dart';
import 'package:erb_mobo/ui/my_profile/bloc/myprofilebloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common_widgets/ReceiptDetailsWidgets/receipt_details.dart';
import '../../../models/deduction.dart';
import '../../../models/salary.dart';

class ReceiptList extends StatelessWidget {
  final MyprofileblocBloc myprofileblocBloc;
  const ReceiptList({Key? key, required this.myprofileblocBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Receipt rec = Receipt(
      id: 1,
      userName: 'userNameT',
      deductions: [
        Deduction(amount: 10, reason: 'daily task ...', type: 'work deduction'),
        Deduction(amount: 10, reason: 'daily task ...', type: 'work deduction'),
        Deduction(amount: 10, reason: 'daily task ...', type: 'work deduction'),
      ],
      salary: Salary(
        id: 1,
        receiptId: 1,
        allowance: 200,
        amount: 100,
        bonus: 30,
        receiptName: 'receiptName',
      ),
    );
    return ListView(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(15),
      ),
      children: [
        Column(
          children: [
            buildSalaryDetails(
              'salary name',
              'Receipt Name :',
              context,
              rec,
            ),
            buildSalaryDetails(
              'salary name',
              'Receipt Name :',
              context,
              rec,
            ),
            buildSalaryDetails(
              'salary name',
              'Receipt Name :',
              context,
              rec,
            ),
          ],
        ),
      ],
    );

    // BlocBuilder(
    //   // buildWhen: (previous, current) =>
    //   //     previous != current && current is SuccessFetchMyProfileInfo ||
    //   //     current is ErrorFetchMyProfileInfo,
    //   bloc: myprofileblocBloc,
    //   builder: (context, state) {
    //     if (state is SuccessFetchMyProfileInfo) {
    //       return state.user.receipts != null
    //           ? ListView.builder(
    //               itemCount: state.user.receipts!.length,
    //               itemBuilder: (BuildContext context, int index) {
    //                 return buildSalaryDetails(
    //                     state.user.receipts![index].id.toString(),
    //                     'Receipt Name :',
    //                     context,
    //                     state.user.receipts![index]);
    //               })
    //           : const Center(
    //               child: Text('Not prepering receipts yet'),
    //             );
    //     } else if (state is ErrorFetchMyProfileInfo) {
    //       return const Center(
    //         child: Text('some thing is wrong'),
    //       );
    //     } else if (state is FetchingMyProfileInfo) {
    //       return Center(
    //         child: CircularProgressIndicator(
    //           color: Theme.of(context).primaryColor,
    //         ),
    //       );
    //     }
    //     return Container();
    //   },
    // );
  }

  Widget buildSalaryDetails(String getValue, String title, BuildContext context,
          Receipt receiptDetails) =>
      Padding(
        padding: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(25),
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
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReceiptDetails(
                            receipt: receiptDetails, isMyReceipt: false)),
                  );
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        getValue,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                          height: ScreenUtil().setHeight(1.5),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Theme.of(context).primaryColor,
                      size: ScreenUtil().setSp(27),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
}
