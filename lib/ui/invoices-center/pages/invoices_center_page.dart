import 'package:erb_mobo/ui/invoices-center/widgets/inv_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common_widgets/app_drawer.dart';
import '../bloc/invoice_bloc.dart';
import '../widgets/enum/inv_filter_type_enum.dart';
import 'create_invoice_page.dart';

class InvoicesCenterPage extends StatefulWidget {
  const InvoicesCenterPage({Key? key}) : super(key: key);

  @override
  State<InvoicesCenterPage> createState() => _InvoicesCenterPageState();
}

class _InvoicesCenterPageState extends State<InvoicesCenterPage> {
  InvoiceBloc invoiceBloc = InvoiceBloc();
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
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Company Invoices',
              style: TextStyle(color: Colors.white),
            ),
            elevation: 0.0,
            backgroundColor: Theme.of(context).primaryColor,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            bottom: PreferredSize(
              preferredSize: Size(
                0,
                ScreenUtil().setHeight(60),
              ),
              child: const TabBar(
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
              )
            ],
          ),
          body: BlocBuilder(
            bloc: invoiceBloc,
            builder: (context, state) {
              if (state is SuccessGettingInvoices) {
                return TabBarView(
                  children: [
                    // for all filter
                    InvFilter(
                      invoiceList: state.invoiceList,
                      filterType: InvFilterTypeEnum.all,
                      invBloc: invoiceBloc,
                    ),
                    // for review filter
                    InvFilter(
                      invoiceList: state.invoiceList,
                      filterType: InvFilterTypeEnum.review_pending,
                      invBloc: invoiceBloc,
                    ),
                    // for approve filter
                    InvFilter(
                      invoiceList: state.invoiceList,
                      filterType: InvFilterTypeEnum.approval_pending,
                      invBloc: invoiceBloc,
                    ),
                    // for payment filter
                    InvFilter(
                      invoiceList: state.invoiceList,
                      filterType: InvFilterTypeEnum.payment_pending,
                      invBloc: invoiceBloc,
                    ),
                  ],
                );
              } else if (state is GettingInvoices) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    strokeWidth: ScreenUtil().setWidth(3),
                  ),
                );
              } else if (state is ErrorGettingInvoices) {
                return Center(
                  child: Text('some thing is wrong'),
                );
              }
              return Container();
            },
          ),
          drawer: const AppDrawer(),
        ),
      ),
    );
  }
}
