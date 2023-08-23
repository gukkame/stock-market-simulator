import 'package:flutter/material.dart';
import 'package:stock_market/components/stock_market_field.dart';

import '../provider/provider_manager.dart';
import '../utils/stock/market_stock.dart';
import '../utils/colors.dart';
import '../utils/user.dart';

class StockList extends StatefulWidget {
  const StockList({super.key});

  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  late User user;
  String errorMSg = "Stocks not found!";
  List<MarketStock> allStocks = [];

  @override
  void initState() {
    user = ProviderManager().getUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    allStocks = ProviderManager().getStocks(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: Column(
        children: [
          _title,
          Expanded(
            child: allStocks.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : _stockListView,
          )
        ],
      ),
    );
  }

  Widget get _stockListView {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        if (allStocks.isNotEmpty)
          for (var stock in allStocks)
            StockMarketField(
              companyTitle: stock.symbol,
              buyPrice: stock.buyPrice,
              // sellPrice: stock.sellPrice,
            )
        else
          _setInfoWidget
      ],
    );
  }

  Widget get _title {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: primeColorTrans, width: 2))),
      child: ListTile(
        onTap: null,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _titleStyle("Company"),
              // _titleStyle("Sell"),
              // const SizedBox(
              //   width: 70,
              // ),
              _titleStyle("Buy"),
              
            ]),
      ),
    );
  }

  Widget _titleStyle(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.w600, color: primeColor, fontSize: 17),
      ),
    );
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
}
