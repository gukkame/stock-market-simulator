import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_market/pages/portfolio.dart';
import 'package:stock_market/provider/provider_manager.dart';
import 'package:stock_market/provider/stock_provider.dart';
import 'package:stock_market/provider/wallet_provider.dart';

import 'pages/authentication/login.dart';
import 'pages/authentication/signup.dart';
import 'pages/stock_marker_info.dart';
import 'pages/transaction_page.dart';
import 'pages/stock_list_page.dart';
import 'provider/user_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
        ChangeNotifierProvider(create: (_) => StockProvider()),
        ChangeNotifierProvider(create: (_) => ProviderManager()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
      ],
      child: MaterialApp(
        title: 'Stock Simulator',
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => LogIn(),
          '/signup': (context) => SignUp(),
          '/trade': (context) => const TransactionPage(),
          '/stocks': (context) => const StockListPage(),
          '/stock-info': (context) => const StockInfoPage(),
          '/portfolio': (context) => const PortfolioPage(),
        },
      ),
    );
  }
}
