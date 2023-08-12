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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("    Stock List"),
            IconButton(
              onPressed: logOut,
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: const StockList(),
      bottomNavigationBar: const BottomNavBar(index: 1),
    );
  }

  void logOut() {
    debugPrint("logOut");
  }
}
