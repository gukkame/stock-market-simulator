import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_market/api/stock_api.dart';
import 'package:stock_market/provider/provider_manager.dart';
import 'package:stock_market/provider/wallet_provider.dart';
import 'package:stock_market/utils/colors.dart';
import 'package:stock_market/utils/stock/market_stock.dart';
import 'package:stock_market/utils/stock/user_stock.dart';

import '../components/container.dart';
import '../components/stock_info_field.dart';

class Transactions extends StatefulWidget {
  final String page;
  final String companyTitle;
  final MarketStock stock;

  const Transactions({
    super.key,
    required this.page,
    required this.companyTitle,
    required this.stock,
  });

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  int _currentCount = 1000;
  late WalletProvider wallet;

  double get _totalBuyPrice {
    return widget.stock.buyPrice *
        _currentCount *
        (widget.page == "buy" ? 1 : -1);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.page);
    wallet = ProviderManager().getWallet(context);
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
            "${widget.page.toUpperCase()}  AMOUNT  \$",
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
            "Units (amount/price) $_totalBuyPrice \$",
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
    if (_totalBuyPrice <= wallet.total) {
      ProviderManager().getWallet(context).buyStock(
            context,
            UserStock(
              symbol: widget.companyTitle,
              date: Timestamp.now(),
              value: widget.stock.buyPrice * (widget.page == "buy" ? 1 : -1),
              amount: _currentCount.toDouble(),
            ),
          );
    }
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
                    "${widget.page.toUpperCase()} $_totalBuyPrice \$",
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
      _currentCount += 100;
    });
  }

  void decrement() {
    debugPrint("decrement");
    debugPrint(_currentCount.toString());
    setState(() {
      if (_currentCount > 0) {
        _currentCount -= 100;
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
