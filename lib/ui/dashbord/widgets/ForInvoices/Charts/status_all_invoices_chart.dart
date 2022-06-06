import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;

class StatusAllInvoicesChart extends StatelessWidget {
  const StatusAllInvoicesChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
    return Column(
      children: [
        Flexible(
          flex: 0,
           fit : FlexFit.loose,
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
          flex:6,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Card(
                elevation: 3,
                child: Container(
                  child: SfCircularChart(
                    borderColor: Theme.of(context).primaryColor,
                    // Enables the tooltip for all the series in chart
                    tooltipBehavior: _tooltipBehavior,

                    legend: Legend(isVisible: true),
                    series: [
                      // Initialize line series
                      PieSeries<ChartDataForCircularChart, String>(
                        // Enables the tooltip for individual series
                        enableTooltip: true,
                        dataSource: [
                          // Bind data source
                          ChartDataForCircularChart('upload', 35),
                          ChartDataForCircularChart('reviewed', 28),
                          ChartDataForCircularChart('paid', 34),
                          ChartDataForCircularChart('rejected', 32),
                          ChartDataForCircularChart('compleated', 40)
                        ],
                        xValueMapper: (ChartDataForCircularChart data, _) =>
                            data.x,
                        yValueMapper: (ChartDataForCircularChart data, _) =>
                            data.y,
                        name: 'Data',
                      )
                    ],
                  ),
                ),
              ),
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
                  'Upload more invoices to see data!',
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

class ChartDataForCircularChart {
  ChartDataForCircularChart(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
