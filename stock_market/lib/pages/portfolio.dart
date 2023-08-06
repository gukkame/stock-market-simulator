import 'package:flutter/material.dart';

import '../components/bottom_nav_bar.dart';
import '../screens/portfolio.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  @override
  Widget build(BuildContext context) {
     return  Scaffold(
      appBar: AppBar(title: const Text("Stock List"),),
      body: const Portfolio(),
      bottomNavigationBar: const BottomNavBar(index: 2),
    );
  }
}