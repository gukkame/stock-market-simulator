import 'package:flutter/cupertino.dart';

import '../api/stock_api.dart';
import '../utils/stock/user_stock.dart';
import '../utils/user.dart';

class WalletProvider extends ChangeNotifier {
  final StockApi _api = StockApi();
  List<UserStock> _holding = [];
  double _total = 0;
  bool _hasInit = false;

  bool get hasInit => _hasInit;

  double get total => _total;
  List<UserStock> get holding => _holding;

  Future<void> buyStock(User user, UserStock stock) async {
    _total = _total - stock.price;
    _holding.add(stock);
    await _api.buyStock(user, stock);
    notifyListeners();
  }

  Future<void> sellStock(User user, double price, UserStock stock) async {
    _total = _total + price;
    _holding.removeWhere((e) => e == stock);
    await _api.sellStock(user, price, stock);
    notifyListeners();
  }

  Future<void> init(User user) async {
    var data = await StockApi().getWalletData(user);
    _total = double.parse("${data['total']}");
    _holding = List<UserStock>.from(
        data['holdings'].map((stockData) => UserStock.from(stockData)));
    _hasInit = true;
    notifyListeners();
  }
}
