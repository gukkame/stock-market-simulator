import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_market/provider/provider_manager.dart';
import 'package:stock_market/utils/stock/market_stock.dart';
import 'package:stock_market/utils/stock/user_stock.dart';
import 'container.dart';

class StockPortfolioField extends StatefulWidget {
  const StockPortfolioField(
      {super.key, required this.companyTitle, required this.stock});
  final String companyTitle;
  final UserStock stock;
  @override
  State<StockPortfolioField> createState() => _StockFieldState();
}

//On StockList page and portfolio page
//On Portfolio, I have company price, units bought, value
//on StockList I have company, Buy, Sell buttons, on top of them are price at sell, at buy

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
                    _textStyle((widget.stock.price).toString(), 16),
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
    ProviderManager()
        .getWallet(context)
        .sellStock(context, marketStock.sellPrice, widget.stock);
  }
}
