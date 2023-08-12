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
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 20,
      selectedIconTheme: const IconThemeData(color: primeColor),
      selectedItemColor: primeColor,
      unselectedItemColor: primeColor,
      // unselectedFontSize: 10,
      unselectedLabelStyle: const TextStyle(fontSize: 13, height: 0),
      showUnselectedLabels: true,
      enableFeedback: false,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.bar_chart,
            size: 0,
          ),
          label: '  \$ 1 000 000',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.bar_chart,
            size: 28,
          ),
          label: 'Stock List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart, size: 28),
          label: 'Portfolio',
        ),
      ],
      onTap: _onItemTapped,
    );
  }
}
