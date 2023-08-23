import 'package:flutter/material.dart';

import '../screens/transactions.dart';
import '../utils/colors.dart';
import '../utils/navigation.dart';
import '../utils/stock/market_stock.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late String page;
  late String companyTitle;
  late MarketStock stock;

  @override
  void didChangeDependencies() {
    page = Arguments.from(context).arg![0];
    debugPrint(page);

    companyTitle = Arguments.from(context).arg![1];



    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primeColorTrans,
      appBar: AppBar(
        title: const Text("Trade"),
        actions: <Widget>[_transactionBtn],
        backgroundColor: secondaryColor.withOpacity(0.2),
        shadowColor: Colors.transparent,
      ),
      body: Transactions(
        page: page,
        companyTitle: companyTitle,
        // stock: stock,
      ),
    );
  }

  Widget get _transactionBtn {
    return Row(
      children: [
        // for (int i = 0; i < 2; i++) ...[
          SizedBox(
            width: 80,
            height: 40,
            child: FittedBox(
              fit: BoxFit.fill,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerRight,
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: () => onTap(1),
                child: Container(
                  decoration: BoxDecoration(
                      color: (page == "buy") 
                          ? primeColor
                          : primeColorTrans,
                      borderRadius: BorderRadius.circular(6.0)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 23.0, vertical: 6.0),
                    child: Text(
                      // i == 1 ? 
                      "Buy" ,
                      // : "Sell",
                      style:  TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ]
      // ],
    );
  }

  void onTap(int option) {
    if (option == 1) {
      setState(() {
        page = "buy";
      });
    } else {
      setState(() {
        page = "sell";
      });
    }
  }
}
