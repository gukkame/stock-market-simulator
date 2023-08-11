import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  Transactions({super.key, required this.page});

  late String page;

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.page),
      ],
    );
  }
}
