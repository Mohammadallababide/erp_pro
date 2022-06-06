import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;

class SplineChartForInvoicesPaid extends StatelessWidget {
  const SplineChartForInvoicesPaid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ChartDataForInvoicesPaidStatus> chartData = [
      ChartDataForInvoicesPaidStatus(2010, 35),
      ChartDataForInvoicesPaidStatus(2011, 13),
      ChartDataForInvoicesPaidStatus(2012, 34),
      ChartDataForInvoicesPaidStatus(2013, 27),
      ChartDataForInvoicesPaidStatus(2014, 40)
    ];
    return Column(
      children: [
        Flexible(
          flex: 0,
          fit: FlexFit.loose,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(5),
            ),
            child: Text(
              'Invoices status quo',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(25),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 6,
          child: Stack(
            children: [
              Card(
                  elevation: 3,
                  child: Container(
                    child: SfCartesianChart(
                        borderColor: Theme.of(context).primaryColor,
                        // Enables the tooltip for all the series in chart

                        // title: ChartTitle(
                        //   text: 'Invoices paid total',
                        //   textStyle: TextStyle(
                        //     color: Theme.of(context).primaryColor,
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: ScreenUtil().setSp(17),
                        //   ),
                        // ),
                        legend: Legend(isVisible: true),
                        series: <ChartSeries>[
                          // Renders spline chart
                          SplineSeries<ChartDataForInvoicesPaidStatus, int>(
                              dataSource: chartData,
                              xValueMapper:
                                  (ChartDataForInvoicesPaidStatus data, _) =>
                                      data.x,
                              yValueMapper:
                                  (ChartDataForInvoicesPaidStatus data, _) =>
                                      data.y)
                        ]),
                  )),
              BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: 10.0,
                  sigmaY: 10.0,
                ),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Pay more invoices to see chart data!',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChartDataForInvoicesPaidStatus {
  ChartDataForInvoicesPaidStatus(this.x, this.y);
  final int x;
  final double? y;
}
