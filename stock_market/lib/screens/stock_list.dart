import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_market/components/stock_field.dart';
import 'package:stock_market/utils/stock.dart';

import '../provider/provider_manager.dart';
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
          _title,
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                if (allStocks.isNotEmpty)
                  for (var stock in allStocks)
                    StockField(
                      companyTitle: stock.symbol,
                      buyPrice: stock.price[0],
                      sellPrice: stock.price[1],
                    )
                else
                  _setInfoWidget
              ],
            ),
          )
        ],
      ),
    );
  }

  void getStockList() {
    //!Fetch data from database|| CompanyName, Buy price, Sell price
    allStocks.add(Stock(
      symbol: "TSLA",
      date: Timestamp(43, 32),
      buyPrice: 4478.03,
      sellPrice: 4478.03,
    ));
    allStocks.add(Stock(
      symbol:"NVDA",
      date:Timestamp(43, 32),
      buyPrice:234.3,
      sellPrice:221.3,
    ));
   
    allStocks.add(Stock(
      symbol: "TSLA",
      date: Timestamp(43, 32),
      buyPrice: 4478.03,
      sellPrice: 4478.03,
    ));
    allStocks.add(Stock(
      symbol:"NVDA",
      date:Timestamp(43, 32),
      buyPrice:234.3,
      sellPrice:221.3,
    ));
   
    allStocks.add(Stock(
      symbol: "TSLA",
      date: Timestamp(43, 32),
      buyPrice: 4478.03,
      sellPrice: 4478.03,
    ));
    allStocks.add(Stock(
      symbol:"NVDA",
      date:Timestamp(43, 32),
      buyPrice:234.3,
      sellPrice:221.3,
    ));
   
    allStocks.add(Stock(
      symbol: "TSLA",
      date: Timestamp(43, 32),
      buyPrice: 4478.03,
      sellPrice: 4478.03,
    ));
    allStocks.add(Stock(
      symbol:"NVDA",
      date:Timestamp(43, 32),
      buyPrice:234.3,
      sellPrice:221.3,
    ));
   
    allStocks.add(Stock(
      symbol: "TSLA",
      date: Timestamp(43, 32),
      buyPrice: 4478.03,
      sellPrice: 4478.03,
    ));
    allStocks.add(Stock(
      symbol:"NVDA",
      date:Timestamp(43, 32),
      buyPrice:234.3,
      sellPrice:221.3,
    ));
   
    allStocks.add(Stock(
      symbol: "TSLA",
      date: Timestamp(43, 32),
      buyPrice: 4478.03,
      sellPrice: 4478.03,
    ));
    allStocks.add(Stock(
      symbol:"NVDA",
      date:Timestamp(43, 32),
      buyPrice:234.3,
      sellPrice:221.3,
    ));
   
    allStocks.add(Stock(
      symbol: "TSLA",
      date: Timestamp(43, 32),
      buyPrice: 4478.03,
      sellPrice: 4478.03,
    ));
    allStocks.add(Stock(
      symbol:"NVDA",
      date:Timestamp(43, 32),
      buyPrice:234.3,
      sellPrice:221.3,
    ));
   
    allStocks.add(Stock(
      symbol: "TSLA",
      date: Timestamp(43, 32),
      buyPrice: 4478.03,
      sellPrice: 4478.03,
    ));
    allStocks.add(Stock(
      symbol:"NVDA",
      date:Timestamp(43, 32),
      buyPrice:234.3,
      sellPrice:221.3,
    ));
   
    allStocks.add(Stock(
      symbol: "TSLA",
      date: Timestamp(43, 32),
      buyPrice: 4478.03,
      sellPrice: 4478.03,
    ));
    allStocks.add(Stock(
      symbol:"NVDA",
      date:Timestamp(43, 32),
      buyPrice:234.3,
      sellPrice:221.3,
    ));
   
    allStocks.add(Stock(
      symbol: "TSLA",
      date: Timestamp(43, 32),
      buyPrice: 4478.03,
      sellPrice: 4478.03,
    ));
    allStocks.add(Stock(
      symbol:"NVDA",
      date:Timestamp(43, 32),
      buyPrice:234.3,
      sellPrice:221.3,
    ));
   
  }

  Widget get _title {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: primeColorTrans, width: 2))),
      child: ListTile(
        onTap: null,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _titleStyle("Company"),
              const SizedBox(
                width: 65,
              ),
              _titleStyle("Buy"),
              const SizedBox(
                width: 70,
              ),
              _titleStyle("Sell"),
            ]),
      ),
    );
  }

  Widget _titleStyle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w600, color: primeColor, fontSize: 17),
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

  void _setErrorState(String msg) {
    errorMSg = msg;
  }
}
