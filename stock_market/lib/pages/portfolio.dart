import 'package:flutter/material.dart';

import '../components/bottom_nav_bar.dart';
import '../provider/provider_manager.dart';
import '../screens/portfolio.dart';
import '../utils/navigation.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("   Portfolio"),
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
      body: const Portfolio(),
      bottomNavigationBar: const BottomNavBar(index: 2),
    );
  }

   void logOut() async {
    await ProviderManager().logOut(context);
    redirect();
  }

  void redirect() {
    navigate(context, "/login");
  }
}
