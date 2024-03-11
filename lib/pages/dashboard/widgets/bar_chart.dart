import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  BarChart({super.key});
  @override
  BarChartState createState() => BarChartState();
}

class BarChartState extends State<BarChart> {
  late List<ChartData> data;
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    data = [
      ChartData('Today', 100),
      ChartData('20 Feb', 15),
      ChartData('19 Feb', 30),
      ChartData('18 Feb', 6.4),
      ChartData('17 Feb', 14)
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
        maximum: 100,
        interval: 10,
      ),
      tooltipBehavior: _tooltip,
      series: <CartesianSeries<ChartData, String>>[
        ColumnSeries<ChartData, String>(
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            name: 'Amount',
            color:const Color.fromRGBO(8, 142, 255, 1))
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
