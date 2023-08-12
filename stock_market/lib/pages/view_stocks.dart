import 'package:flutter/material.dart';

import '../components/bottom_nav_bar.dart';
import '../screens/stock_list.dart';

class StockListPage extends StatefulWidget {
  const StockListPage({super.key});

  @override
  State<StockListPage> createState() => StockListPageState();
}

class StockListPageState extends State<StockListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock List"),
        automaticallyImplyLeading: false,
      ),
      body: const StockList(),
      bottomNavigationBar: const BottomNavBar(index: 1),
    );
  }
}
