import 'package:flutter/material.dart';

import '../components/line_chart.dart';
import '../components/stock_info_field.dart';
import '../utils/navigation.dart';

class StockInfo extends StatefulWidget {
  const StockInfo({super.key});

  @override
  State<StockInfo> createState() => _StockInfoState();
}

class _StockInfoState extends State<StockInfo> {
  @override
  Widget build(BuildContext context) {
    String? title = Arguments.from(context).symbol;

    title ??= "error finding company";

    var fullCompanyName = "NVIDIA Corporation";
    var stockPrice = 234.23;
    var persentChange = -2.22;
    var logo = "";

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      StockInfoField(
          title: title,
          fullCompanyName: fullCompanyName,
          stockPrice: stockPrice,
          persentChange: persentChange,
          logo: logo),
          SizedBox(height: 50,),
      StockLineChart(),
    ]);
  }

  void _getStockInfo() {
    //! Get info from DB about the stock
    // Save info into stock class var
  }
}
