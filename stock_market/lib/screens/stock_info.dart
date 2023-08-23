import 'package:flutter/material.dart';

import '../components/line_chart.dart';
import '../components/stock_info_field.dart';
import '../utils/colors.dart';
import '../utils/navigation.dart';

class StockInfo extends StatefulWidget {
  final String title;

  const StockInfo({required this.title, Key? key}) : super(key: key);

  @override
  State<StockInfo> createState() => _StockInfoState();
}

class _StockInfoState extends State<StockInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StockInfoField(
              title: widget.title,
            ),
            const SizedBox(
              height: 10,
            ),
            StockLineChart(widget.title),
            const SizedBox(
              height: 35,
            ),
            _transactionBtn,
          ]),
    );
  }

  Widget get _transactionBtn {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // for (int i = 0; i < 2; i++) ...[
          SizedBox(
            width: 100,
            child: FittedBox(
              fit: BoxFit.fill,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerRight,
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: () => onTap(0),
                child: Container(
                  decoration: BoxDecoration(
                      color: primeColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6.0)),
                  child: const Padding(
                    padding:  EdgeInsets.symmetric(
                        horizontal: 23.0, vertical: 8.0),
                    child: Text(
                      // i == 0 ? 
                      "Buy" ,
                      // : "Sell",
                      style:  TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ]
      // ],
    );
  }

  void onTap(int option) {
    if (option == 0) {
      debugPrint("Buy");
      navigate(context, "/trade", args: {
        "arg": ["buy", widget.title]
      });
    } else {
      debugPrint("Sell");
      navigate(context, "/trade", args: {
        "arg": ["sell", widget.title]
      });
    }
  }
}
