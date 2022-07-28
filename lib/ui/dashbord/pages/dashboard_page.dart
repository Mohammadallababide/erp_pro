import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:erb_mobo/common/common_widgets/commomn_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/animationAppWidget.dart';
import '../../../common/common_widgets/app_drawer.dart';
import '../../../common/common_widgets/common_bottom_navigation_bar.dart';
import '../../../common/common_widgets/custom_app_button.dart';
import '../../../common/controllers/invoices_controller.dart';
import '../../../models/invoice.dart';
import '../../invoices-center/bloc/invoice_bloc.dart';
import '../widgets/ForInvoices/dashboard_card.dart';
import '../widgets/ForInvoices/dashboard_charts_slider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final InvoiceBloc invoiceBloc = InvoiceBloc();
  late bool isLoading = true;
  late InvoicesController invoicesController;
  late List<Invoice> invoices = [];

  @override
  void initState() {
    super.initState();
    invoiceBloc.add(GetInvoices());
  }

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
        bottomNavigationBar: CommonBottomNavigationBar(),
        body: BlocListener(
          bloc: invoiceBloc,
          listener: (context, state) async {
            if (state is SuccessGettingInvoices) {
              await Future.delayed(
                Duration(seconds: 3),
              );
              setState(
                () => {
                  isLoading = false,
                  invoices = state.invoiceList,
                  invoicesController = InvoicesController(invoices)
                },
              );
            } else if (state is ErrorGettingInvoices) {
              await Future.delayed(
                Duration(seconds: 3),
              );
              setState(
                () => {
                  isLoading = false,
                },
              );
            }
          },
          child: isLoading
              ? AnimationAppWidget(
                  name: AnimationWidgetNames.dashbordLoadder,
                )
              : BlocBuilder(
                  bloc: invoiceBloc,
                  builder: (context, state) {
                    if (state is SuccessGettingInvoices) {
                      return CustomScrollView(
                        primary: false,
                        slivers: <Widget>[
                          SliverPadding(
                            padding: const EdgeInsets.all(5),
                            sliver: SliverGrid.count(
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: 0.95,
                              crossAxisCount: 2,
                              children: <Widget>[
                                DashBoardCard(
                                  title: 'Invoice Overdue',
                                  icon: Icons.receipt,
                                  value: invoicesController
                                      .getOverdueInvoices()
                                      .length
                                      .toString(),
                                  color: Color.fromARGB(255, 211, 107, 130),
                                  otherTitle: 'total worth \n(AED)',
                                  otherValue: invoicesController
                                          .getTotalWorth(invoicesController
                                              .getOverdueInvoices())
                                          .toString() +
                                      ' \$',
                                ),
                                DashBoardCard(
                                  title: 'Invoices to be paid',
                                  icon: Icons.monetization_on_rounded,
                                  value: invoicesController
                                      .getToBePaidInvoices()
                                      .length
                                      .toString(),
                                  color: Color.fromARGB(255, 168, 217, 242),
                                  otherTitle: 'total worth \n(AED)',
                                  otherValue: invoicesController
                                          .getTotalWorth(invoicesController
                                              .getToBePaidInvoices())
                                          .toString() +
                                      ' \$',
                                ),
                                DashBoardCard(
                                  title: 'Invoices assigned to me',
                                  icon: Icons.supervisor_account_rounded,
                                  value: invoicesController
                                      .getAssignedToMeInvoices()
                                      .length
                                      .toString(),
                                  color: Color.fromARGB(255, 242, 233, 168),
                                  otherTitle: 'total worth \n(AED)',
                                  otherValue: invoicesController
                                          .getTotalWorth(invoicesController
                                              .getAssignedToMeInvoices())
                                          .toString() +
                                      ' \$',
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
                            sliver: SliverToBoxAdapter(
                                child: DashBoardChartsSlider(
                              invoices: invoices,
                            )),
                          ),
                        ],
                      );
                    } else if (state is ErrorGettingInvoices) {
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
                              setState(() => {
                                    isLoading = true,
                                  });
                              invoiceBloc.add(GetInvoices());
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
                ),
        ),
      ),
    );
  }
}


