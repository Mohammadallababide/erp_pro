import 'package:erb_mobo/common/common_widgets/commomn_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/common_widgets/app_drawer.dart';
import '../widgets/ForInvoices/dashboard_card.dart';
import '../widgets/ForInvoices/dashboard_charts_slider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: commonAppBar(context: context, title: 'Dashboard'),
        drawer: const AppDrawer(),
        body: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(5),
              sliver: SliverGrid.count(
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 1.1,
                crossAxisCount: 2,
                children: <Widget>[
                  DashBoardCard(
                    title: 'Invoice Overdue',
                    icon: Icons.receipt,
                    value: '3',
                    color: Color.fromARGB(255, 211, 107, 130),
                    otherTitle: 'total worth \n(AED)',
                    otherValue: '19.1653116',
                  ),
                  DashBoardCard(
                    title: 'Invoices to be paid',
                    icon: Icons.monetization_on_rounded,
                    value: '2',
                    color: Color.fromARGB(255, 168, 217, 242),
                    otherTitle: 'total worth \n(AED)',
                    otherValue: '13.1561',
                  ),
                  DashBoardCard(
                    title: 'Invoices assigned to me',
                    icon: Icons.supervisor_account_rounded,
                    value: '3',
                    color: Color.fromARGB(255, 242, 233, 168),
                    otherTitle: 'total worth \n(AED)',
                    otherValue: '0',
                  ),
                  DashBoardCard(
                    title: 'Total invoices exported',
                    icon: Icons.copy,
                    value: '0',
                    color: Color.fromARGB(255, 206, 221, 228),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(5),
              sliver: SliverToBoxAdapter(child: DashBoardChartsSlider()),
            ),
          ],
        ),
      ),
    );
  }
}
