import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pyramend/dashboard/data/models/chart_spline_data.dart';
import 'package:pyramend/dashboard/views/home_page.dart';
import 'package:pyramend/shared/styles/colors/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartContainer extends StatelessWidget {
  const ChartContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 1.75,
      decoration: BoxDecoration(
        color: Ucolor.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: SfCartesianChart(
        // Customizing Data Labels
        onDataLabelRender: (DataLabelRenderArgs args) {
          if (args.pointIndex == 4) {
            args.text = '7 km';
            args.textStyle = TextStyle(
              fontSize: 16,
              color: Ucolor.black,
              fontWeight: FontWeight.w900,
            );
          } else {
            args.text = ' ';
          }
        },
        // Customizing Markers
        onMarkerRender: (MarkerRenderArgs args) {
          if (args.pointIndex != 4) {
            args.markerHeight = 0;
            args.markerWidth = 0;
          }
        },
        // Chart styling
        plotAreaBackgroundColor: Colors.transparent,
        margin: EdgeInsets.zero,
        borderWidth: 0,
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          axisLine: const AxisLine(width: 0),
          labelPlacement: LabelPlacement.onTicks,
          edgeLabelPlacement: EdgeLabelPlacement.shift,
        ),
        primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(width: 0),
          numberFormat: NumberFormat.compactCurrency(
            locale: 'ar',
            symbol: 'km',
            decimalDigits: 0,
          ),
          maximum: 10,
          minimum: 2,
        ),
        series: <CartesianSeries>[
          SplineSeries<ChartSplineData, String>(
            color: Ucolor.fitnessPrimaryColor2,
            width: 2,
            dataSource: chartData,
            xValueMapper: (ChartSplineData data, _) => data.month,
            yValueMapper: (ChartSplineData data, _) => data.amount,
          ),
          SplineAreaSeries<ChartSplineData, String>(
            dataSource: chartData,
            xValueMapper: (ChartSplineData data, _) => data.month,
            yValueMapper: (ChartSplineData data, _) => data.amount,
            gradient: LinearGradient(
              colors: [
                Ucolor.fitnessPrimaryColor2,
                Ucolor.fitnessPrimaryColor2.withAlpha(23),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          SplineSeries<ChartSplineData, String>(
            color: Ucolor.primaryColor2,
            width: 2,
            markerSettings: MarkerSettings(
              isVisible: true,
              color: Ucolor.gray,
              borderColor: Ucolor.primaryColor2,
              borderWidth: 4,
              height: 20,
              width: 20,
            ),
            dataSource: chartData2,
            xValueMapper: (ChartSplineData data, _) => data.month,
            yValueMapper: (ChartSplineData data, _) => data.amount,
          ),
        ],
      ),
    );
  }
}
