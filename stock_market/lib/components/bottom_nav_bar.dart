import 'package:flutter/material.dart';
import 'package:stock_market/provider/provider_manager.dart';
import 'package:stock_market/provider/wallet_provider.dart';

import '../utils/navigation.dart';
import '../utils/colors.dart';

class BottomNavBar extends StatefulWidget {
  final int index;
  const BottomNavBar({super.key, required this.index});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;
  late WalletProvider wallet;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (_selectedIndex) {
      case 0:
        navigate(context, "/stocks");
        break;
      case 1:
        navigate(context, "/stocks");
        break;
      case 2:
        navigate(context, "/portfolio");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = widget.index;
    wallet = ProviderManager().getWallet(context, listen: true);
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 20,
      selectedIconTheme: const IconThemeData(color: primeColor),
      selectedItemColor: primeColor,
      unselectedItemColor: primeColor,
      unselectedLabelStyle: const TextStyle(fontSize: 13, height: 0),
      showUnselectedLabels: true,
      enableFeedback: false,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.bar_chart,
            size: 0,
          ),
          label: '  \$ ${wallet.total.toStringAsFixed(2)}',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.bar_chart,
            size: 28,
          ),
          label: 'Stock List',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart, size: 28),
          label: 'Portfolio',
        ),
      ],
      onTap: _onItemTapped,
    );
  }
}
