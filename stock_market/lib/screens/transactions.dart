import 'package:flutter/material.dart';

import '../components/stock_info_field.dart';

class Transactions extends StatefulWidget {
  Transactions({super.key, required this.page, required this.companyTitle});

  late String page;
  late String companyTitle;

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StockInfoField(title: widget.companyTitle,),
        Text(widget.page),
      ],
    );
  }
}
