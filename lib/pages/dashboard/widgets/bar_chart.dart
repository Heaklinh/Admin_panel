import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  BarChart({Key? key}) : super(key: key);
  @override
  BarChartState createState() => BarChartState();
}

class BarChartState extends State<BarChart> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    data = [
      _ChartData('Today', 12),
      _ChartData('20 Feb', 15),
      _ChartData('19 Feb', 30),
      _ChartData('18 Feb', 6.4),
      _ChartData('17 Feb', 14)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBackgroundColor: Colors.transparent, // Remove grid background
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0), // Remove vertical grid lines
      ),
      primaryYAxis: const NumericAxis(
        majorGridLines:
            MajorGridLines(width: 0), // Remove horizontal grid lines
        minimum: 0,
        maximum: 40,
        interval: 10,
      ),
      tooltipBehavior: _tooltip,
      series: <CartesianSeries<_ChartData, String>>[
        ColumnSeries<_ChartData, String>(
            dataSource: data,
            xValueMapper: (_ChartData data, _) => data.x,
            yValueMapper: (_ChartData data, _) => data.y,
            name: 'Amount',
            color: Color.fromRGBO(8, 142, 255, 1))
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}
