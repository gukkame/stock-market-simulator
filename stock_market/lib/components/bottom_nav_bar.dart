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
        navigate(context, "/map");
        break;
      case 1:
        navigate(context, "/friend-list");
        break;
      case 2:
        navigate(context, "/invite");
        break;
      case 3:
        navigate(context, "/search");
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
          icon: Icon(Icons.map),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Friends',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.email_outlined),
          label: 'Invite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
      ],
      onTap: _onItemTapped,
    );
  }
}
