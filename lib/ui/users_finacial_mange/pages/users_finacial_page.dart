import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/animationAppWidget.dart';
import '../../../common/common_widgets/ReceiptDetailsWidgets/receipt_details.dart';
import '../../../common/common_widgets/app_drawer.dart';
import '../../../common/common_widgets/commomn_app_bar.dart';
import '../../../common/common_widgets/custom_app_button.dart';
import '../../../common/theme_helper.dart';
import '../../../models/receipt.dart';
import '../bloc/usersfinaicalmange_bloc.dart';
import '../widgets/UsersFinacialPage/rececipt_card.dart';
import 'create_or_edit_receipt_page.dart';

class UsersFinacialPage extends StatefulWidget {
  const UsersFinacialPage({Key? key}) : super(key: key);

  @override
  State<UsersFinacialPage> createState() => _UsersFinacialPageState();
}

class _UsersFinacialPageState extends State<UsersFinacialPage> {
  final UsersfinaicalmangeBloc receiptBloc = UsersfinaicalmangeBloc();
  late int page = 1;
  late bool isLoading = true;
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
        appBar: commonAppBar(
          context: context,
          title: 'Users Finacial Mangment',
          actions: [
            IconButton(
              onPressed: () async {
                final bool? shouldRefresh = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateOrEditUserReceiptPage(
                      createReceiptListCallBack:
                          lisentToAddActionInReceiptsList,
                    ),
                  ),
                );
                if (shouldRefresh != null) {
                  if (shouldRefresh) {
                    receiptBloc.add(
                      GetReceipts(page),
                    );
                  }
                }
              },
              icon: Icon(
                Icons.add_circle,
                size: ScreenUtil().setSp(28),
              ),
            )
          ],
        ),
        drawer: const AppDrawer(),
        body: BlocListener(
            bloc: receiptBloc,
            listener: (context, state) async {
              if (state is SuccessGettinReceipts) {
                await Future.delayed(
                  Duration(seconds: 3),
                );
                setState(() {
                  receiptsList = state.receipts;
                  isLoading = false;
                });
              } else if (state is ErrorGettingReceipts) {
                await Future.delayed(
                  Duration(seconds: 3),
                );
                setState(() {
                  isLoading = false;
                });
              }
            },
            child: isLoading
                ? AnimationAppWidget(
                    name: AnimationWidgetNames.ProgressIndicator,
                  )
                : BlocBuilder(
                    bloc: receiptBloc,
                    builder: (context, state) {
                      if (state is SuccessGettinReceipts) {
                        receiptsList = state.receipts.reversed.toList();
                        return receiptsList.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimationAppWidget(
                                    name: AnimationWidgetNames.empty1,
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(20)),
                                  Column(
                                    children: [
                                      Text(
                                        'There is no receipts created yet!',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.bebasNeue(
                                          fontStyle: FontStyle.normal,
                                          textStyle: TextStyle(
                                            fontSize: ScreenUtil().setSp(25),
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height: ScreenUtil().setHeight(20)),
                                      InkWell(
                                        onTap: () async {
                                          final bool? shouldRefresh =
                                              await Navigator.push<bool>(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateOrEditUserReceiptPage(
                                                createReceiptListCallBack:
                                                    lisentToAddActionInReceiptsList,
                                              ),
                                            ),
                                          );
                                          if (shouldRefresh != null) {
                                            if (shouldRefresh) {
                                              receiptBloc.add(
                                                GetReceipts(page),
                                              );
                                            }
                                          }
                                        },
                                        child: CustomAppButton(
                                          title: 'add new one',
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: receiptsList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return RececiptCard(
                                          receipt: receiptsList[index],
                                          index: index,
                                          detailsButton:
                                              buildDetailsButtonForSalaryCard(
                                                  receiptsList[index]),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                      } else if (state is ErrorGettingReceipts) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimationAppWidget(
                              name: AnimationWidgetNames.networkError,
                            ),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            Text(
                              'There Some Thing Wrong!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bebasNeue(
                                fontStyle: FontStyle.normal,
                                textStyle: TextStyle(
                                  fontSize: ScreenUtil().setSp(25),
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            InkWell(
                              onTap: () {
                                receiptBloc.add(
                                  GetReceipts(page),
                                );
                                setState(() => {
                                      isLoading = true,
                                    });
                              },
                              child: CustomAppButton(
                                title: 'retry',
                              ),
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  )),
      ),
    );
  }

  Align buildDetailsButtonForSalaryCard(Receipt receiptDetails) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () async {
          final bool? shouldRefresh = await Navigator.push<bool>(
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
          if (shouldRefresh != null) {
            if (shouldRefresh) {
              receiptBloc.add(
                GetReceipts(page),
              );
            }
          }
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
}
