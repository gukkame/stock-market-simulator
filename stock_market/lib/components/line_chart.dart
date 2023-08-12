import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class StockLineChart extends StatefulWidget {
  const StockLineChart({super.key});

  @override
  State<StockLineChart> createState() => _StockLineChartState();
}

class _StockLineChartState extends State<StockLineChart> {
  List<Color> gradientColors = [
    secondaryColor,
    primeColorTrans.withOpacity(0.0),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 2000,
        height: 400,
        child: Padding(
          padding: const EdgeInsets.only(
              right: 18.0, left: 12.0, top: 24, bottom: 12),
          child: LineChart(
            mainData(),
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

    final step = data.length ~/ 8;
    if (value.toInt() % step == 0) {
      final index = value.toInt() ~/ step;
      text = Text('0:${(index * 5).toString().padLeft(2, '0')}', style: style);
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

    String text = const {
          1: '10K',
          3: '30K',
          5: '50K',
          7: '70K',
          9: '90K',
        }[value.toInt()] ??
        '';

    return Text(text, style: style, textAlign: TextAlign.left);
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
            interval: 1,
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
      minY: 0,
      maxY: 10,
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
}

final data = [
  3.45,
  2.14,
  16.0,
  1.88,
  1.71,
  1.85,
  1.77,
  1.79,
  2.14,
  2.25,
  2.29,
  2.31,
  2.79,
  2.54,
  2.72,
  2.37,
  2.35,
  2.41,
  2.66,
  2.79,
  3.04,
  3.58,
  4.29,
  3.99,
  4.42,
  // 8,
].asMap();

//! Figure out how data works
/*final data = [
  345,
  214,
  188,
  202,
  225,
  220,
  218,
  249,
  287,
  306,
  300,
  235,
  208,
  222,
  224,
  243,
  214,
  216,
  216,
  185,
  202,
  190,
  212,
  171,
  185,
  177,
  179,
  214,
  225,
  229,
  231,
  279,
  254,
  272,
  237,
  235,
  241,
  266,
  279,
  304,
  358,
  429,
  399,
  442,
  505,
  501,
  551,
  890,
  816,
  561,
  523,
  519,
  419,
  372,
  310,
  297,
  218,
  245,
  233,
  229,
  231,
  231,
  302,
  343,
  350,
  325,
  299,
  308,
  354,
  412,
  404,
  474,
  542,
  770,
  592,
  525,
  580,
  582,
  503,
  499,
  462,
  462,
  446,
  612,
  613,
  537,
  538,
  570,
  633,
  626,
  592,
  541,
  515,
  634,
  616,
  658,
  615,
  613,
  695,
  716,
  646,
  717,
  762,
  952,
  175,
  341,
  030,
  305,
  868,
  754,
  688,
  716,
  625,
  620,
  616,
  713,
  490,
  584,
  741,
  673,
  654,
  800,
  711,
  759,
  763,
  734,
  621,
  621,
  608,
  674,
  709,
  711,
  799,
  853,
  941,
  017,
  126,
  268,
  108,
  825,
  766,
  674,
  667,
  582,
  524,
  451,
  395,
  358,
  383,
  379,
  337,
  314,
  299,
  400,
  366,
  534,
  583,
  532,
  429,
  403,
  413,
  479,
  462,
  432,
  389,
  343,
  370,
  425,
  449,
  408,
  397,
  424,
  430,
  454,
  441,
  405,
  389,
  356,
  324,
  316,
  266,
  250,
  216,
  194,
  243,
  245,
  295,
  283,
  285,
  331,
  354,
  333,
  333,
  333,
  381,
  416,
  404,
  383,
  362,
  343,
  362,
  368,
  364,
  424,
  470,
  688,
  490,
  466,
  458,
  458,
  404,
  391,
  391,
  377,
  412,
  347,
  299,
  287,
  283,
  260,
  285,
  277,
  283,
  277,
  266,
  233,
  208,
  192,
  227,
  198,
  172,
  191,
  191,
  258,
  281,
  281,
  299,
  297,
  254,
  358,
  329,
  285,
  287,
  310,
  314,
  297,
  297,
  289,
  297,
  287,
  300,
  281,
  387,
  266,
  268,
  279,
  279,
  297,
  283,
  295,
  377,
  327,
  408,
  404,
  310,
  268,
  295,
  264,
  264,
  239,
  237,
  222,
  256,
  233,
  264,
  222,
  202,
  190,
  179,
  173,
  175,
  162,
  177,
  229,
].asMap();
 */