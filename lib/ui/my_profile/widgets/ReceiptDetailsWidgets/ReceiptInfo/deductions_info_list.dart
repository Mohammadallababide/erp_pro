import 'package:erb_mobo/models/deduction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeductionsInfoList extends StatelessWidget {
  final List<Deduction> deductionList;
  const DeductionsInfoList({Key? key, required this.deductionList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: deductionList.length,
        itemBuilder: (BuildContext context, int index) {
          return builddeductionCard(index.toString(), 'deduction num :',
              context, deductionList[index]);
        });
  }

  Future<void> _showChoiceDialog(BuildContext context, Deduction deduction) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                  builddeductionDetails(deduction.amount.toString(),
                      'deduction amount :', context),
                  Divider(
                    height: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                  builddeductionDetails(deduction.reason.toString(),
                      'deduction reason :', context),
                  Divider(
                    height: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                  builddeductionDetails(
                      deduction.type.toString(), 'deduction type :', context),
                ],
              ),
            ),
          );
        });
  }

  Widget builddeductionCard(String getValue, String title, BuildContext context,
          Deduction deduction) =>
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
                onTap: () => _showChoiceDialog(context, deduction),
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

  Widget builddeductionDetails(
          String getValue, String title, BuildContext context) =>
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
