import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common_widgets/ReceiptDetailsWidgets/ReceiptInfo/rececipt_list_widget.dart';
import '../../../../models/user.dart';
import '../shared/bottom_sheet_widgets/header_of_bottom_sheet.dart';
import '../userProfilePageWidgets/card_info.dart';

class SalaryInfoCard extends StatefulWidget {
  SalaryInfoCard({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<SalaryInfoCard> createState() => _SalaryInfoCardState();
}

class _SalaryInfoCardState extends State<SalaryInfoCard>
    with TickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(text: "Recipts Info"),
    Tab(text: "Salary Job"),
    // Tab(text: "Latest")
  ];
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: tabs.length, vsync: this);
  }

  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openBottomSheetContent(context),
      child: CardInfo(
        title: 'Salary info',
        icon: Icons.monetization_on,
      ),
    );
  }

  openBottomSheetContent(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(ScreenUtil().radius(20)),
          topStart: Radius.circular(ScreenUtil().radius(20)),
        ),
      ),
      builder: (context) => SingleChildScrollView(
          padding: EdgeInsetsDirectional.only(
            start: ScreenUtil().setWidth(10),
            end: ScreenUtil().setWidth(10),
            bottom: 30,
            top: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderOfBottomSheet(
                  title: 'Salary Info', icon: Icons.monetization_on),
              Center(
                child: TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BubbleTabIndicator(
                    indicatorHeight: ScreenUtil().setHeight(25),
                    indicatorColor: Colors.indigo,
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,

                    // Other flags
                    // indicatorRadius: 1,
                    // insets: EdgeInsets.all(1),
                    // padding: EdgeInsets.all(10)
                  ),
                  tabs: tabs,
                  controller: _tabController,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(5),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(300),
                child: TabBarView(controller: _tabController, children: [
                  ReceiptListWidget(
                    receipts: widget.user.receipts,
                  ),
                  Container(),
                ]),
              ),
            ],
          )),
    );
  }

  Padding buildInfoSectionRow(
      {required String title,
      required String value,
      bool isBottomPadding = true}) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: isBottomPadding ? ScreenUtil().setHeight(20) : 0,
        left: ScreenUtil().setWidth(5),
        right: ScreenUtil().setWidth(5),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.teal,
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(7),
          ),
          Text(
            value.toLowerCase(),
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
