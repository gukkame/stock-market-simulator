import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_market/provider/stock_provider.dart';
import 'package:stock_market/utils/stock/market_stock.dart';

import '../../utils/user.dart';
import 'user_provider.dart';

class ProviderManager extends ChangeNotifier {
  User getUser(BuildContext context) {
    return Provider.of<UserDataProvider>(context, listen: false).user;
  }

  void setUser(BuildContext context, User user) {
    Provider.of<UserDataProvider>(context, listen: false).user = user;
  }

  Future<void> initStocks(BuildContext context) {
    return Provider.of<StockProvider>(context).init();
  }

  List<MarketStock> getStocks(BuildContext context) {
    return Provider.of<StockProvider>(context).stocks.values.toList();
  }

  void disposeStocks(BuildContext context) {
    Provider.of<StockProvider>(context).dispose();
  }
}
