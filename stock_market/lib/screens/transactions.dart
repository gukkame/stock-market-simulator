import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_market/provider/provider_manager.dart';
import 'package:stock_market/provider/wallet_provider.dart';
import 'package:stock_market/utils/colors.dart';
import 'package:stock_market/utils/stock/market_stock.dart';
import 'package:stock_market/utils/stock/stock_trade_data.dart';
import 'package:stock_market/utils/stock/symbol_profile.dart';
import 'package:stock_market/utils/stock/user_stock.dart';

import '../components/container.dart';
import '../components/stock_info_field.dart';

class Transactions extends StatefulWidget {
  final String page;
  final String companyTitle;
  // final MarketStock stock;

  const Transactions({
    super.key,
    required this.page,
    required this.companyTitle,
    // required this.stock,
  });

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  int _currentCount = 10;
  late WalletProvider wallet;
  MarketStock stock =
      MarketStock(data: StockTradeData(symbol: "x"), profile: SymbolProfile());

  double get _totalBuyPrice {
    return stock.buyPrice * _currentCount;
  }

  @override
  void didChangeDependencies() {
    var mStock = ProviderManager().getStock(context, widget.companyTitle);
    if (mStock == null) {
      throw Exception("couldn't find company ${widget.companyTitle}");
    }
    stock = mStock;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(widget.page);
    wallet = ProviderManager().getWallet(context, listen: true);
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StockInfoField(
            title: widget.companyTitle,
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            "${widget.page.toUpperCase()}  UNITS ",
            style: const TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 17,
          ),
          _amountScale,
          const SizedBox(
            height: 10,
          ),
          Text(
            "Price ${_totalBuyPrice.toStringAsFixed(2)} \$",
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white30,
                fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 260,
          ),
          Text(
            "Cash Available  ${wallet.total} \$",
            style: const TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 20,
          ),
          _setOrderBtn,
        ],
      ),
    );
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
                  Text(
                    _totalBuyPrice <= wallet.total
                        ? "Order filled"
                        : "Wallet balance too low",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "${widget.page.toUpperCase()} ${_totalBuyPrice.toStringAsFixed(2)} \$",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
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

    if (_totalBuyPrice <= wallet.total) {
      Timer(const Duration(seconds: 1), () {
        ProviderManager().getWallet(context).buyStock(
              context,
              UserStock(
                symbol: widget.companyTitle,
                date: Timestamp.now(),
                value: stock.buyPrice,
                amount: _currentCount.toDouble(),
              ),
            );
      });
    }
  }

  Widget get _setOrderBtn {
    return TextButton(
      onPressed: () {
        _showDialog(context);
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerRight,
        splashFactory: NoSplash.splashFactory,
      ),
      child: Container(
        height: 40,
        width: 150,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: primeGradient, borderRadius: BorderRadius.circular(6.0)),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0),
          child: Text(
            "Set Order",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w200, fontSize: 16),
          ),
        ),
      ),
    );
  }

  void increment() {
    debugPrint("increment");
    debugPrint(_currentCount.toString());
    setState(() {
      _currentCount += 5;
    });
  }

  void decrement() {
    debugPrint("decrement");
    debugPrint(_currentCount.toString());
    setState(() {
      if (_currentCount > 0) {
        _currentCount -= 5;
      } else {
        _currentCount = 0;
      }
    });
  }

  Widget get _amountScale {
    return RoundedGradientContainer(
      backgroundColor: primeColorDark,
      borderSize: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _createIncrementButton(Icons.remove, decrement),
          Text(
            _currentCount.toString(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w300, fontSize: 20),
          ),
          _createIncrementButton(Icons.add, increment),
        ],
      ),
    );
  }

  Widget _createIncrementButton(IconData icon, Function onPressed) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: const BoxConstraints(minWidth: 42.0, minHeight: 42.0),
      onPressed: () => onPressed(),
      elevation: 2.0,
      shape: const CircleBorder(),
      child: Icon(
        icon,
        color: Colors.white,
        size: 18.0,
      ),
    );
  }
}
