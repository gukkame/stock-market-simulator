import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'container.dart';

class StockPortfolioField extends StatefulWidget {
  StockPortfolioField({
    super.key,
    required this.companyTitle,
    required this.amount,
    required this.sellPrice,
  });
  String companyTitle;
  double amount;
  double sellPrice;
  @override
  State<StockPortfolioField> createState() => _StockFieldState();
}

//On StockList page and porfolio page
//On Porfolio, I have company price, units bought, value
//on StockList I have company, Buy, Sell buttons, on top of them are price at sell, at buy

class _StockFieldState extends State<StockPortfolioField> {
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
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                
                  _textStyle(widget.companyTitle, 18),
          
                  _textStyle(widget.amount.toString(),16),
                  _textStyle(widget.amount.toString(),16),
                  _textStyle(widget.sellPrice.toString(),16),
                ],
              )),
        ),
      ],
    );
  }

  Widget _textStyle(String title, double fontsize) {
    return SizedBox(
      width: 60,
      height: 40,
      child: FittedBox(
        alignment: Alignment.centerLeft,
        fit: BoxFit.scaleDown,
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontsize,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
      ),
    );
  }

  void _onTitleTap() {
    debugPrint("Company tapped");
    debugPrint(widget.companyTitle);
    //  navigate(context, "/stock-info");
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
