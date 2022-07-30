import 'package:erb_mobo/ui/invoices-center/widgets/inv_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/animationAppWidget.dart';
import '../../../common/common_widgets/app_drawer.dart';
import '../../../common/common_widgets/common_add_FLB.dart';
import '../../../common/common_widgets/common_scaffold_app.dart';
import '../../../common/common_widgets/custom_app_button.dart';
import '../../../common/controllers/invoices_controller.dart';
import '../bloc/invoice_bloc.dart';
import '../widgets/enum/inv_filter_type_enum.dart';
import 'create_invoice_page.dart';

class InvoicesCenterPage extends StatefulWidget {
  const InvoicesCenterPage({Key? key}) : super(key: key);

  @override
  State<InvoicesCenterPage> createState() => _InvoicesCenterPageState();
}

class _InvoicesCenterPageState extends State<InvoicesCenterPage>
    with SingleTickerProviderStateMixin {
  InvoiceBloc invoiceBloc = InvoiceBloc();
  late bool isLoading = true;
  late bool isError = false;
  late TabController _controller;
  @override
  void initState() {
    _controller = new TabController(length: 4, vsync: this);
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
      child: BlocListener(
        bloc: invoiceBloc,
        listener: (context, state) async {
          if (state is SuccessGettingInvoices) {
            await Future.delayed(
              Duration(seconds: 3),
            );
            setState(
              () => {
                isLoading = false,
                isError = false,
              },
            );
          } else if (state is ErrorGettingInvoices) {
            await Future.delayed(
              Duration(seconds: 3),
            );
            setState(
              () => {
                isLoading = false,
                isError = true,
              },
            );
          }
        },
        child: isError
            ? Scaffold(
                drawer: AppDrawer(),
                appBar: AppBar(
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  centerTitle: true,
                  title: const Text(
                    'Company Invoices',
                    style: TextStyle(color: Colors.white),
                  ),
                  elevation: 0.0,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                body: Column(
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
                              isError = false,
                            });
                        invoiceBloc.add(GetInvoices());
                      },
                      child: CustomAppButton(
                        title: 'retry',
                      ),
                    ),
                  ],
                ),
              )
            : CommonScaffoldApp(
                title: 'Company Invoices',
                actions: [
                  IconButton(
                    onPressed: () async {
                      final bool? shouldRefresh = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateInvoicePage(),
                        ),
                      );
                      if (shouldRefresh != null) {
                        if (shouldRefresh) {
                          // refresh invoice center page ...
                          invoiceBloc.add(GetInvoices());
                        }
                      }
                    },
                    icon: Icon(
                      Icons.add_circle,
                      size: ScreenUtil().setSp(28),
                    ),
                  ),
                ],
                flb: CommonAddFLB(
                  icon: Icons.add,
                  func: () async {
                    final bool? shouldRefresh = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateInvoicePage(),
                      ),
                    );
                    if (shouldRefresh != null) {
                      if (shouldRefresh) {
                        // refresh invoice center page ...
                        invoiceBloc.add(GetInvoices());
                      }
                    }
                  },
                ),
                bottom: PreferredSize(
                  preferredSize: Size(
                    0,
                    ScreenUtil().setHeight(60),
                  ),
                  child: TabBar(
                    controller: _controller,
                    tabs: [
                      Tab(
                        icon: null,
                        text: 'All',
                        iconMargin: const EdgeInsets.all(0),
                      ),
                      Tab(
                        icon: null,
                        text: 'Review',
                        iconMargin: const EdgeInsets.all(0),
                      ),
                      Tab(
                        icon: null,
                        text: 'Approval',
                        iconMargin: const EdgeInsets.all(0),
                      ),
                      Tab(
                        icon: null,
                        text: 'Payment',
                        iconMargin: const EdgeInsets.all(0),
                      ),
                    ],
                  ),
                ),
                child: isLoading
                    ? AnimationAppWidget(
                        name: AnimationWidgetNames.ProgressIndicator,
                      )
                    : BlocBuilder(
                        bloc: invoiceBloc,
                        builder: (context, state) {
                          if (state is SuccessGettingInvoices) {
                            InvoicesController invoicesController =
                                InvoicesController(state.invoiceList);
                            return TabBarView(
                              controller: _controller,
                              children: [
                                // for all filter
                                InvFilter(
                                  invoiceList: state.invoiceList,
                                  invBloc: invoiceBloc,
                                ),
                                // for review filter
                                InvFilter(
                                  invoiceList: invoicesController
                                      .getToBeReviwedInvoices(),
                                  invBloc: invoiceBloc,
                                ),
                                // for approve filter
                                InvFilter(
                                  invoiceList: invoicesController
                                      .getToBeApprovedInvoices(),
                                  invBloc: invoiceBloc,
                                ),
                                // for payment filter
                                InvFilter(
                                  invoiceList:
                                      invoicesController.getToBePaidInvoices(),
                                  invBloc: invoiceBloc,
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
