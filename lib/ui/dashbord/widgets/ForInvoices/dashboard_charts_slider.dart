import 'package:erb_mobo/ui/dashbord/widgets/slides_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/invoice.dart';
import './Charts/spline_chart_For_invoices_paid.dart';
import 'Charts/status_all_invoices_chart.dart';

class DashBoardChartsSlider extends StatefulWidget {
  final List<Invoice> invoices;
  const DashBoardChartsSlider({Key? key, required this.invoices}) : super(key: key);

  @override
  State<DashBoardChartsSlider> createState() => _DashBoardChartsSliderState();
}

class _DashBoardChartsSliderState extends State<DashBoardChartsSlider> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    // Timer.periodic(Duration(seconds: 15), (Timer timer) {
    //   if (_currentPage < 2) {
    //     _currentPage++;
    //   } else {
    //     _currentPage = 0;
    //   }

    //   _pageController.animateToPage(
    //     _currentPage,
    //     duration: Duration(milliseconds: 300),
    //     curve: Curves.easeInOut,
    //   );
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Container(
          height: ScreenUtil().setHeight(300),
          child: PageView(
            scrollDirection: Axis.horizontal,
            // controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              StatusAllInvoicesChart(invoices: widget.invoices,),
              SplineChartForInvoicesPaid(),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: ScreenUtil().setHeight(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 0; i < 2; i++)
                if (i == _currentPage) SlideDots(true) else SlideDots(false)
            ],
          ),
        )
      ],
    );
  }
}
