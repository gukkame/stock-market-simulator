import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stock_market/utils/colors.dart';
import 'package:stock_market/utils/navigation.dart';

import '../components/container.dart';
import '../components/stock_info_field.dart';

class Transactions extends StatefulWidget {
  Transactions({super.key, required this.page, required this.companyTitle});

  late String page;
  late String companyTitle;

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  int _currentCount = 1000;

  @override
  Widget build(BuildContext context) {
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
          const Text(
            "Units (amount/price) XXX \$",
            style: TextStyle(
                fontSize: 14,
                color: Colors.white30,
                fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 260,
          ),
          const Text(
            "Cash Available  XXX \$",
            style: TextStyle(
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
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              height: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Order filled",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "${widget.page.toUpperCase()} $_currentCount \$",
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

  void dicrement() {
    debugPrint("decriment");
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
          _createIncrementDicrementButton(Icons.remove, dicrement),
          Text(
            _currentCount.toString(),
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w300, fontSize: 20),
          ),
          _createIncrementDicrementButton(Icons.add, increment),
        ],
      ),
    );
  }

  Widget _createIncrementDicrementButton(IconData icon, Function onPressed) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minWidth: 42.0, minHeight: 42.0),
      onPressed: () => onPressed(),
      elevation: 2.0,
      child: Icon(
        icon,
        color: Colors.white,
        size: 18.0,
      ),
      shape: CircleBorder(),
    );
  }
}
