import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_market/provider/stock_provider.dart';
import 'package:stock_market/utils/stock/market_stock.dart';

import '../../utils/user.dart';
import 'user_provider.dart';
import 'wallet_provider.dart';

class ProviderManager extends ChangeNotifier {
  /* User */
  User getUser(BuildContext context) {
    return Provider.of<UserDataProvider>(context, listen: false).user;
  }

  void setUser(BuildContext context, User user) {
    Provider.of<UserDataProvider>(context, listen: false).user = user;
  }

  /* Stock */

  Future<void> initStocks(BuildContext context) {
    return Provider.of<StockProvider>(context, listen: false).init();
  }

  List<MarketStock> getStocks(BuildContext context) {
    return Provider.of<StockProvider>(context).stocks.values.toList();
  }

  MarketStock? getStock(BuildContext context, String symbol) {
    var provider = Provider.of<StockProvider>(context);
    return provider.stocks.containsKey(symbol) ? provider.stocks[symbol] : null;
  }

  // void resetWebsocket(BuildContext context) {
  //   Provider.of<StockProvider>(context, listen: false).reset();
  // }

  void disposeStocks(BuildContext context) {
    Provider.of<StockProvider>(context).clear();
  }

  /* Wallet */

  Future<void> initWallet(BuildContext context, User user) {
    return Provider.of<WalletProvider>(context, listen: false).init(user);
  }

  WalletProvider getWallet(BuildContext context, {bool listen = false}) {
    return Provider.of<WalletProvider>(context, listen: listen);
  }

  /* Functionality */

  Future<void> logOut(BuildContext context) async {
    Provider.of<StockProvider>(context, listen: false).dispose();
    await getUser(context).logOut();
  }
}
