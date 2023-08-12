import 'package:flutter/material.dart';

import '../components/line_chart.dart';
import '../components/stock_info_field.dart';
import '../utils/colors.dart';
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StockInfoField(
              title: title,
              fullCompanyName: fullCompanyName,
              stockPrice: stockPrice,
              persentChange: persentChange,
              logo: logo),
          const SizedBox(
            height: 50,
          ),
          const StockLineChart(),
          const SizedBox(
            height: 35,
          ),
          _transactionBtn,
        ]);
  }

  void _getStockInfo() {
    //! Get info from DB about the stock
    // Save info into stock class var
  }
  Widget get _transactionBtn {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 2; i++)
          SizedBox(
            width: 120,
            height: 50,
            child: FittedBox(
              fit: BoxFit.fill,
              child: TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(0, 4, 10, 4),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerRight),
                onPressed: () => onTap(i),
                child: Container(
                  decoration: BoxDecoration(
                      color: primeColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 23.0, vertical: 6.0),
                    child: Text(
                      i == 0 ? "Buy" : "Sell",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  void onTap(int option) {
    if (option == 0) {
      debugPrint("Buy");
      // navigate(context, "/buy");
    } else {
      debugPrint("Sell");
      // navigate(context, "/sell");
    }
  }
}
