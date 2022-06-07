import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;

import '../../../../../common/controllers/invoices_controller.dart';
import '../../../../../models/invoice.dart';

class StatusAllInvoicesChart extends StatefulWidget {
  final List<Invoice> invoices;

  StatusAllInvoicesChart({Key? key, required this.invoices}) : super(key: key);

  @override
  State<StatusAllInvoicesChart> createState() => _StatusAllInvoicesChartState();
}

class _StatusAllInvoicesChartState extends State<StatusAllInvoicesChart> {
  late InvoicesController invoicesController;
  @override
  void initState() {
    super.initState();
    invoicesController = InvoicesController(widget.invoices);
  }

  @override
  Widget build(BuildContext context) {
    late TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
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
                        dataSource: getChartsData(),

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
              widget.invoices.isEmpty
                  ? Stack(
                      children: [
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
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }

  List<ChartDataForCircularChart> getChartsData() {
    List<ChartDataForCircularChart> result = [];
    invoicesController.getAllInvoicesStatsMap().map((e) {
      e.forEach((key, value) {
        result.add(ChartDataForCircularChart(key, value));
      });
    }).toList();
    return result;
  }
}

class ChartDataForCircularChart {
  ChartDataForCircularChart(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
