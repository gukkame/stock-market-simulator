import '../api/stock_api.dart';
import 'stock.dart';
import 'user.dart';

class Wallet {
  late int total;
  late List<Stock> holdings;
  late List<Stock> history;

  Future<Wallet> fetchWallet(User user) async {
    var data = await StockApi().getWalletData(user);
    total = data['total'];
    holdings = List<Stock>.from(
        data['holdings'].map((stockData) => Stock.from(stockData)));
    history = List<Stock>.from(
        data['history'].map((stockData) => Stock.from(stockData)));
    return this;
  }

  Wallet();
}
