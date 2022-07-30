import 'package:erb_mobo/ui/invoices-center/widgets/section_card_related_to_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/costant.dart';
import '../../../models/invoice.dart';

class MoreInvInfoFloattingButton extends StatelessWidget {
  final Invoice inv;
  const MoreInvInfoFloattingButton({
    Key? key,
    required this.inv,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Icons.more_horiz,
            color: Colors.white,
          ),
        ),
        onPressed: () => showMoreInvoiceInfo(context),
      ),
    );
  }

  Future<void> showMoreInvoiceInfo(
    BuildContext context,
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
                      ScetionCardRelatedToUser(
                          title: 'Invoice reviewed by :',
                          userInfoRealted: inv.reviewedBy),
                      ScetionCardRelatedToUser(
                          title: 'Invoice paid by :',
                          userInfoRealted: inv.paidBy),
                      ScetionCardRelatedToUser(
                          title: 'Invoice approved by :',
                          userInfoRealted: inv.approvedBy),
                      ScetionCardRelatedToUser(
                          title: 'Invoice rejected by :',
                          userInfoRealted: inv.rejectedBy),
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
