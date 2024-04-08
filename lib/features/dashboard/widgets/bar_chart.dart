import 'package:admin_panel/models/order.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class BarChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  final List<Order>? orderList;
  final String type;
  const BarChart({super.key, required this.orderList, required this.type});
  @override
  BarChartState createState() => BarChartState();
}

class BarChartState extends State<BarChart> {
  late List<ChartData> data;
  late TooltipBehavior _tooltip;
  double maximum = 100;
  List<Order> currentDateOrders = [];
  List<Order> dateTwo = [];
  List<Order> dateThree = [];
  List<Order> dateFour = [];
  List<Order> dateFive = [];

  List<String> getDateLabels(List<Order> orders) {
    return orders.map((order) {
      order.orderDate - 1 * 24 * 60 * 60 * 1000;
      return DateFormat('dd MMM').format(
          DateTime.fromMillisecondsSinceEpoch(order.orderDate));
    }).toList();
  }

  // Function to filter orders by date and return a list of orders for the specified period
  List<Order> filterDate({int? year, int? month, int? day}) {
    List<Order> filteredOrders = [];

    for (int i = 0; i < widget.orderList!.length; i++) {
      int orderTimeStamp = widget.orderList![i].orderDate;
      DateTime orderDate = DateTime.fromMillisecondsSinceEpoch(orderTimeStamp);
      int orderYear = orderDate.year;
      int orderMonth = orderDate.month;
      int orderDay = orderDate.day;

      // Check if the order matches the specified year, month, and day
      if ((year == null || orderYear == year) &&
          (month == null || orderMonth == month) &&
          (day == null || orderDay == day)) {
        filteredOrders.add(widget.orderList![i]);
      }
    }

    return filteredOrders;
  }

  @override
  void initState() {
    chartData();
    super.initState();
  }

  void chartData(){
    if(widget.type == "day"){
      currentDateOrders = filterDate(day: DateTime.now().day);
      dateTwo = filterDate(day: (DateTime.now().day - 1));
      dateThree = filterDate(day: (DateTime.now().day - 2));
      dateFour = filterDate(day: (DateTime.now().day - 3));
      dateFive = filterDate(day: (DateTime.now().day - 4));

      data = [
        ChartData(DateFormat('dd MMM').format(DateTime.now().subtract(const Duration(days: 4))), dateFive.length),
        ChartData(DateFormat('dd MMM').format(DateTime.now().subtract(const Duration(days: 3))), dateFour.length),
        ChartData(DateFormat('dd MMM').format(DateTime.now().subtract(const Duration(days: 2))), dateThree.length),
        ChartData(DateFormat('dd MMM').format(DateTime.now().subtract(const Duration(days: 1))), dateTwo.length),
        ChartData('Today', currentDateOrders.length),
      ];
      maximum = 100;
    }else{
      currentDateOrders = filterDate(month: DateTime.now().month);
      dateTwo = filterDate(month: (DateTime.now().month - 1));
      dateThree = filterDate(month: (DateTime.now().month - 2));
      dateFour = filterDate(month: (DateTime.now().month - 3));
      dateFive = filterDate(month: (DateTime.now().month - 4));

      data = [
        ChartData(DateFormat('MMM').format(DateTime.now().subtract(const Duration(days:30 * 4))), dateFive.length),
        ChartData(DateFormat('MMM').format(DateTime.now().subtract(const Duration(days:30 * 3))), dateFour.length),
        ChartData(DateFormat('MMM').format(DateTime.now().subtract(const Duration(days:30 * 2))), dateThree.length),
        ChartData(DateFormat('MMM').format(DateTime.now().subtract(const Duration(days:30 * 1))), dateTwo.length),
        ChartData(DateFormat('MMM').format(DateTime.now().subtract(const Duration(days:0))), currentDateOrders.length),
      ];
      maximum = 2500;
    }
    _tooltip = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBackgroundColor: Colors.transparent, // Remove grid background
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0), // Remove vertical grid lines
      ),
      primaryYAxis: NumericAxis(
        majorGridLines:
            const MajorGridLines(width: 0), // Remove horizontal grid lines
        minimum: 0,
        maximum: maximum,
        interval: 10,
      ),
      tooltipBehavior: _tooltip,
      series: <CartesianSeries<ChartData, String>>[
        ColumnSeries<ChartData, String>(
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            name: 'Amount',
            color:  const Color.fromRGBO(8, 142, 255, 1))
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}
