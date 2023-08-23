import 'package:flutter/material.dart';
import 'package:stock_market/provider/provider_manager.dart';
import 'package:stock_market/utils/stock/market_stock.dart';
import 'package:stock_market/utils/stock/user_stock.dart';
import '../utils/colors.dart';
import 'container.dart';

class StockPortfolioField extends StatefulWidget {
  const StockPortfolioField(
      {super.key, required this.companyTitle, required this.stock});
  final String companyTitle;
  final UserStock stock;
  @override
  State<StockPortfolioField> createState() => _StockFieldState();
}

class _StockFieldState extends State<StockPortfolioField> {
  late MarketStock marketStock;

  @override
  Widget build(BuildContext context) {
    marketStock =
        ProviderManager().getStock(context, widget.companyTitle) as MarketStock;
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: _onStockTap,
          child: RoundedGradientContainer(
            borderSize: 2,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _textStyle(widget.companyTitle, 18),
                    _textStyle(widget.stock.amount.toString(), 16),
                    _textStyle((widget.stock.price).toStringAsFixed(2), 16),
                    _textStyle(
                        (marketStock.buyPrice * widget.stock.amount)
                            .toStringAsFixed(2),
                        16),
                  ],
                )),
          ),
        ),
      ],
    );
  }

  Widget _textStyle(String title, double fontSize) {
    return SizedBox(
      width: 60,
      height: 40,
      child: FittedBox(
        alignment: Alignment.centerLeft,
        fit: BoxFit.scaleDown,
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
      ),
    );
  }

  void _onStockTap() {
    _showDialog(context);
    ProviderManager()
        .getWallet(context)
        .sellStock(context, marketStock.buyPrice, widget.stock);
  }

  void _showDialog(BuildContext context) {
    showDialog(
        barrierColor: Colors.black45,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: primeColorDark,
            shadowColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              height: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Order filled",
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 13,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    " ${widget.stock.amount} Units of ${widget.stock.symbol} were sold at ${(marketStock.buyPrice * widget.stock.amount).roundToDouble()}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
