import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/navigation.dart';
import 'container.dart';

class StockMarketField extends StatefulWidget {
  final String companyTitle;
  // final double sellPrice;
  final double buyPrice;

  const StockMarketField(
      {super.key,
      required this.companyTitle,
      // required this.sellPrice,
      required this.buyPrice});

  @override
  State<StockMarketField> createState() => _StockFieldState();
}

class _StockFieldState extends State<StockMarketField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        RoundedGradientContainer(
          borderSize: 2,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: _onTitleTap,
                    child: Text(
                      widget.companyTitle,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  _transactionBtn,
                ],
              )),
        ),
      ],
    );
  }

  void _onTitleTap() {
    debugPrint("Company tapped");
    debugPrint(widget.companyTitle);
    navigate(context, "/stock-info", args: {"symbol": widget.companyTitle});
  }

  Widget get _transactionBtn {
    return Row(
      children: [
        // for (int i = 0; i < 2; i++) ...[
          SizedBox(
            width: 85,
            height: 40,
            child: FittedBox(
              fit: BoxFit.fill,
              child: TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerRight),
                onPressed: () => onTap(1),
                child: Container(
                  decoration: BoxDecoration(
                      color: primeColorTrans,
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 23.0, vertical: 6.0),
                    child: Text(
                      // i == 0
                      //     ? (widget.buyPrice).toStringAsFixed(2)
                      //     : 
                          widget.buyPrice.toStringAsFixed(2),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          )
        ]
      // ],
    );
  }

  void onTap(int option) {
    if (option == 1) {
      debugPrint("Buy");
      navigate(context, "/trade", args: {
        "arg": ["buy", widget.companyTitle]
      });
    } else {
      debugPrint("Sell");
      navigate(context, "/trade", args: {
        "arg": ["sell", widget.companyTitle]
      });
    }
  }
}
