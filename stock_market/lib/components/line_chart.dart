import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/stock/stock_history.dart';

class StockLineChart extends StatefulWidget {
  final String title;
  const StockLineChart(this.title, {super.key});

  @override
  State<StockLineChart> createState() => _StockLineChartState();
}

class _StockLineChartState extends State<StockLineChart> {
  List<Color> gradientColors = [
    secondaryColor,
    primeColorTrans.withOpacity(0.0),
  ];
  late StockHistory _history;
  Map<int, double> data = month;
  String showData = "Day";
  bool _loading = true;

  @override
  void didChangeDependencies() {
    _loadStockData();
    super.didChangeDependencies();
  }

  void _loadStockData() async {
    _history = await StockHistory().init(widget.title);
    setState(() {
      _loading = false;
      data = _history.daily.asMap();
      showData = "Day";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          _changePeriodBtn("Day"),
          _changePeriodBtn("Week"),
          _changePeriodBtn("Month")
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: showData == "Month"
              ? 500
              : showData == "Week"
                  ? 1100
                  : 1700,
          height: 400,
          child: Padding(
            padding: const EdgeInsets.only(
                right: 18.0, left: 12.0, top: 24, bottom: 12),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _changePeriodBtn(String period) {
    return SizedBox(
      width: 60,
      height: 34,
      child: TextButton(
        onPressed: () {
          if (!_loading) {
            setState(() {
              showData = period;

              switch (period) {
                case "Day":
                  data = _loading ? month : _history.daily.asMap();
                  break;
                case "Week":
                  data = _loading ? month : _history.weekly.asMap();
                  break;
                default:
                  data = _loading ? month : _history.monthly.asMap();
              }
            });
          }
        },
        child: Text(
          period,
          style: TextStyle(
            fontSize: 12,
            color: showData == period
                ? Colors.white.withOpacity(0.5)
                : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text = const Text('', style: style);

    int devider = 12;
    if (showData == "Day") {
      devider = 24;
    } else if (showData == "Week") {
      devider = 18;
    }
    final step = data.length ~/ devider;

    // debugPrint("-------");
    // debugPrint(step.toString());

    if (step != 0 && value.toInt() % step == 0) {
      final index = value.toInt() ~/ step;

      text = Text(((index * step) + 1).toString(), style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    Widget text = const Text('', style: style);
    var h = highestValue();
    final step = h ~/ 6;

    if (step != 0 && value.toInt() % step == 0) {
      final index = value.toInt() ~/ step;
      text = Text(((index * step)).toString(), style: style);
    }
    return text;
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: const FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 2,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: data.length - 1,
      minY: lowestValue() - 0,
      maxY: highestValue() + 0,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (final entry in data.entries) ...[
              FlSpot(entry.key.toDouble(), entry.value.toDouble()),
            ]
          ],
          color: Colors.white,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors,
            ),
          ),
        ),
      ],
    );
  }

  double highestValue() {
    var highestValueFirst = data.values
        .reduce((value, element) => value > element ? value : element);
    return highestValueFirst.toDouble();
  }

  double lowestValue() {
    var lowestValueFirst = data.values
        .reduce((value, element) => value < element ? value : element);
    return lowestValueFirst.toDouble();
  }
}

final month = [
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
  1.0,
].asMap();
