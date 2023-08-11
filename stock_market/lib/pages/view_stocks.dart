import 'package:flutter/material.dart';
import 'package:stock_market/screens/stock_list.dart';

import '../components/bottom_nav_bar.dart';

class StockListPage extends StatefulWidget {
  const StockListPage({super.key});

  @override
  State<StockListPage> createState() => StockListPageState();
}

class StockListPageState extends State<StockListPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Stock List"),),
      body: const StockList(),
      bottomNavigationBar: const BottomNavBar(index: 0),
    );
  }
}
