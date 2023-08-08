import '../../api/stock_api.dart';
import 'user_stock.dart';
import '../user.dart';

class Wallet {
  late int total;
  late List<UserStock> holdings;
  late List<UserStock> history;

  Future<Wallet> fetchWallet(User user) async {
    var data = await StockApi().getWalletData(user);
    total = data['total'];
    holdings = List<UserStock>.from(
        data['holdings'].map((stockData) => UserStock.from(stockData)));
    history = List<UserStock>.from(
        data['history'].map((stockData) => UserStock.from(stockData)));
    return this;
  }

  Wallet();
}
