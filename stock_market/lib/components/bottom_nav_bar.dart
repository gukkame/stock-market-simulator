import 'package:flutter/material.dart';

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
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (_selectedIndex) {
      case 0:
        navigate(context, "/stocks");
        break;
      case 1:
        navigate(context, "/porfolio");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = widget.index;
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.shifting,
      selectedFontSize: 20,
      selectedIconTheme: const IconThemeData(color: primeColor),
      selectedItemColor: primeColor,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Stock List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart),
          label: 'Porfolio',
        ),
      ],
      onTap: _onItemTapped,
    );
  }
}
