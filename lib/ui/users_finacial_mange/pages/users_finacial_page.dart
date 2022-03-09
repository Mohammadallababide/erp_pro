import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/common_widgets/ReceiptDetailsWidgets/receipt_details.dart';
import '../../../common/common_widgets/app_drawer.dart';
import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../common/theme_helper.dart';
import '../../../core/utils/core_util_function.dart';
import '../../../models/receipt.dart';
import '../bloc/usersfinaicalmange_bloc.dart';
import '../widgets/UsersFinacialPage/cus_filter_button.dart';
import 'create_or_edit_receipt_page.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class UsersFinacialPage extends StatefulWidget {
  const UsersFinacialPage({Key? key}) : super(key: key);

  @override
  State<UsersFinacialPage> createState() => _UsersFinacialPageState();
}

class _UsersFinacialPageState extends State<UsersFinacialPage> {
  final UsersfinaicalmangeBloc receiptBloc = UsersfinaicalmangeBloc();
  late int page = 1;
  late List<Receipt> receiptsList = [];
  @override
  void initState() {
    super.initState();
    receiptBloc.add(
      GetReceipts(page),
    );
  }

  void lisentToAddActionInReceiptsList(Receipt newValue) {
    setState(() {
      receiptsList.add(newValue);
    });
  }

  void lisentToEdtActionInReceiptList(Receipt newValue) {
    setState(() {
      for (var element in receiptsList) {
        if (element.id == newValue.id) {
          element = newValue;
        }
      }
    });
  }

  void lisentToDeleteActionInReceipList(int deletedReceiptIndex) {
    setState(() {
      receiptsList.removeWhere((element) => element.id == deletedReceiptIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar:
            commonAppBar(context: context, title: 'Users Finacial Mangment'),
        drawer: const AppDrawer(),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(15),
                vertical: ScreenUtil().setHeight(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateOrEditUserReceiptPage(
                            createReceiptListCallBack:
                                lisentToAddActionInReceiptsList,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: ScreenUtil().setWidth(110),
                      height: ScreenUtil().setHeight(50),
                      decoration: ThemeHelper().buttonBoxDecoration(
                        context: context,
                        radius: ScreenUtil().setSp(15),
                      ),
                      child: Center(
                        child: Text(
                          'New Salary',
                          style: GoogleFonts.belleza(
                            fontStyle: FontStyle.normal,
                            textStyle: TextStyle(
                              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const CusFilterButton(),
                ],
              ),
            ),
            BlocBuilder(
              bloc: receiptBloc,
              builder: (context, state) {
                if (state is SuccessGettinReceipts) {
                  receiptsList = state.receipts.reversed.toList();
                  return Expanded(
                    child: ListView.builder(
                      itemCount: receiptsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildUserRececiptCard(
                          receipt: receiptsList[index],
                          index: index,
                        );
                      },
                    ),
                  );
                } else if (state is GettingReceipts) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height -
                        ScreenUtil().setHeight(210),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                        strokeWidth: ScreenUtil().setWidth(3),
                      ),
                    ),
                  );
                } else if (state is ErrorGettingReceipts) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height -
                        ScreenUtil().setHeight(210),
                    child: const Center(
                      child: Text('some thing is wrong'),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUserRececiptCard({
    required Receipt receipt,
    required int index,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(5),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(10),
              vertical: ScreenUtil().setHeight(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildNumberAndDateRangeSicationForSalaryCard(receipt, index),
                SizedBox(
                  height: ScreenUtil().setHeight(8),
                ),
                buildAsigmentUserSectionForSalaryCard(receipt),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                buildTotalSalarySectionForSalaryCard(receipt),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                buildDetailsButtonForSalaryCard(receipt)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildNumberAndDateRangeSicationForSalaryCard(Receipt receipt, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: ScreenUtil().setHeight(15),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                ScreenUtil().setSp(150),
              ),
              child: Center(
                child: Text(
                  index.toString(),
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Text(
              "From ${CorerUtilFunction.getFormalDate(
                receipt.salary.workStartDate!,
              )} To ${CorerUtilFunction.getFormalDate(
                receipt.salary.workEndDate!,
              )}",
              textDirection: ui.TextDirection.ltr,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(5),
            ),
            Icon(
              Icons.date_range,
              size: ScreenUtil().setSp(15),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ],
    );
  }

  Align buildDetailsButtonForSalaryCard(Receipt receiptDetails) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReceiptDetails(
                receipt: receiptDetails,
                isMyReceipt: true,
                editInReceiptsListCallBack: lisentToEdtActionInReceiptList,
                deleteReceiptCallBack: lisentToDeleteActionInReceipList,
              ),
            ),
          );
        },
        child: Container(
          height: ScreenUtil().setHeight(40),
          width: ScreenUtil().setWidth(75),
          decoration: ThemeHelper().buttonBoxDecoration(context: context),
          child: Center(
            child: Text(
              'Details',
              style: GoogleFonts.belleza(
                fontStyle: FontStyle.normal,
                textStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  int calculateTotalSalarValue(Receipt receipt) {
    int totalDedection = 0;
    for (int i = 0; i < receipt.deductions.length; i++) {
      totalDedection = totalDedection +receipt.deductions[i].amount;
    }
    return (receipt.salary.amount +
            receipt.salary.bonus +
            receipt.salary.allowance) -
        totalDedection;
  }

  Column buildTotalSalarySectionForSalaryCard(Receipt receipt) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Total Salary :",
            textDirection: ui.TextDirection.rtl,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(5),
          ),
          child: Row(
            children: [
              Text(
                calculateTotalSalarValue(receipt).toString(),
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(2),
              ),
              Icon(
                Icons.attach_money_outlined,
                size: ScreenUtil().setSp(20),
              )
            ],
          ),
        ),
      ],
    );
  }

  Column buildAsigmentUserSectionForSalaryCard(Receipt receipt) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Salary To Asignment :",
            textDirection: ui.TextDirection.rtl,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            Container(
              height: ScreenUtil().setSp(25),
              width: ScreenUtil().setSp(25),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Image(
                image: AssetImage('assets/images/useric.png'),
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(7),
            ),
            Text(
              receipt.user!.firstName + ' ' + receipt.user!.lastName,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
