import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stock_market/utils/navigation.dart';

import '../utils/colors.dart';
import 'container.dart';

class StockField extends StatefulWidget {
  StockField(
      {super.key,
      required this.companyTitle,
      required this.sellPrice,
      required this.buyPrice});

  String companyTitle;
  int sellPrice;
  int buyPrice;
  @override
  State<StockField> createState() => _StockFieldState();
}

//On StockList page and porfolio page
//On Porfolio, I have company price, units bought, value
//on StockList I have company, Buy, Sell buttons, on top of them are price at sell, at buy

class _StockFieldState extends State<StockField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: RoundedGradientContainer(
                borderSize: 2,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.companyTitle,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            _transactionBtn,
          ],
        ),
      ],
    );
  }

  void onTap(int option) {
    if (option == 0) {
      navigate(context, "/buy");
    } else {
      navigate(context, "/sell");
    }
  }

  Widget get _transactionBtn {
    return Row(
      children: [
        for (int i = 0; i < 2; i++)
          TextButton(
            style: TextButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerRight),
            onPressed: () => onTap(i),
            child: Container(
              decoration: BoxDecoration(
                  gradient: primeGradient,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 11.0),
                child: Text(
                  i == 0
                      ? (widget.sellPrice).toString()
                      : widget.buyPrice.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
