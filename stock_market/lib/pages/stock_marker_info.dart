import 'package:flutter/material.dart';

import '../screens/stock_info.dart';
import '../utils/colors.dart';

class StockInfoPage extends StatefulWidget {
  const StockInfoPage({super.key});

  @override
  State<StockInfoPage> createState() => _StockInfoPageState();
}

class _StockInfoPageState extends State<StockInfoPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: primeColorTrans,
      appBar: AppBar(title: const Text("Stock Info"),backgroundColor: secondaryColor.withOpacity(0.2),shadowColor: Colors.transparent,),
      body:const StockInfo(),
    );
  }
}
