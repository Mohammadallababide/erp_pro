import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../models/receipt.dart';
import '../receipt_details.dart';

class ReceiptListWidget extends StatelessWidget {
  final List<Receipt>? receipts;
  const ReceiptListWidget({Key? key, required this.receipts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return receipts != null
        ? ListView.builder(
            itemCount: receipts!.length,
            itemBuilder: (BuildContext context, int index) {
              return buildSalaryDetails(receipts![index].id.toString(),
                  'Receipt Name :', context, receipts![index]);
            })
        : const Center(
            child: Text('Not prepering receipts yet'),
          );
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
