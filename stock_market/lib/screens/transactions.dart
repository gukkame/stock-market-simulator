import 'package:flutter/material.dart';
import 'package:stock_market/utils/colors.dart';

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
            height: 25,
          ),
          const Text(
            "AMOUNT \$",
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300),
          ),
             const SizedBox(
            height: 20,
          ),
          _amountScale,
        ],
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
          Text(_currentCount.toString(),style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 20),),
          _createIncrementDicrementButton(Icons.add,  increment),
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
