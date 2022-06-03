import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvoiceInfoCard extends StatelessWidget {
  final String getValue;
  final String title;
  const InvoiceInfoCard({
    Key? key,
    required this.getValue,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildInvoiceInfoCard(context);
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildInvoiceInfoCard(
    BuildContext context,
  ) =>
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
}
