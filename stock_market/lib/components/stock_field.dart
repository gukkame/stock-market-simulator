import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'container.dart';

class StockField extends StatefulWidget {
  StockField(
      {super.key,
      required this.companyTitle,
      required this.sellPrice,
      required this.buyPrice});

  String companyTitle;
  double sellPrice;
  double buyPrice;
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
    //  navigate(context, "/stock-info");
  }

  Widget get _transactionBtn {
    return Row(
      children: [
        for (int i = 0; i < 2; i++)
          SizedBox(
            width: 100,
            height: 40,
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
                      color: primeColorTrans,
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 23.0, vertical: 6.0),
                    child: Text(
                      i == 0
                          ? (widget.sellPrice).toString()
                          : widget.buyPrice.toString(),
                      style: const TextStyle(
                        color: Colors.black,
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
