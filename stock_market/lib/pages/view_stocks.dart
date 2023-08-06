import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_market/components/stock_field.dart';
import 'package:stock_market/utils/stock.dart';

import '../provider/provider_manager.dart';
import '../utils/colors.dart';
import '../utils/user.dart';

class ViewStocks extends StatefulWidget {
  const ViewStocks({super.key});

  @override
  State<ViewStocks> createState() => _ViewStocksState();
}

class _ViewStocksState extends State<ViewStocks> {
  late User user;
  String errorMSg = "Stocks not found!";
  List<Stock> allStocks = [];

  @override
  void initState() {
    user = ProviderManager().getUser(context);
    getStockList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: Column(
        children: [
          if (allStocks.isNotEmpty)
            for (var stock in allStocks)
              StockField(
                companyTitle: stock.symbol,
                buyPrice: stock.amount,
                sellPrice: stock.value,
              )
          else
            _setInfoWidget
        ],
      ),
    );
  }

  void getStockList() {
    //!Fetch data from database|| CompanyName, Buy price, Sell price
    // allStocks.add(Stock("TSLA", Timestamp(43, 32), 234, 213));
  }

  Widget get _setInfoWidget {
    return Center(
        child: Text(
      errorMSg,
      style: const TextStyle(
        color: primeColorTrans,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    ));
  }

  void _setErrorState(String msg) {
    errorMSg = msg;
  }
}
