import 'package:cloud_firestore/cloud_firestore.dart';

class Stock {
  final StockType _type;
  final String _symbol;
  final Timestamp _date;
  double _buyPrice = 0;
  double _sellPrice = 0;
  double _amount = 0;

  String get symbol => _symbol;
  Timestamp get date => _date;
  double get amount => _amount;
  dynamic get price {
    switch (_type) {
      case StockType.market:
        return [_buyPrice, _sellPrice];
      case StockType.user:
        return _amount * _buyPrice;
      default:
    }
  }

  Map<String, dynamic> get data {
    return {
      "symbol": symbol,
      "date": date,
      "value": _buyPrice,
      "amount": amount,
    };
  }

  factory Stock.from(Map<String, dynamic> data) {
    return Stock(
      type: data["type"],
      symbol: data["symbol"],
      date: data["date"],
      buyPrice: data["buyPrice"],
      sellPrice: data["sellPrice"],
      amount: data["amount"],
    );
  }

  Stock({
    required String symbol,
    required Timestamp date,
    required double buyPrice,
    double sellPrice = 0,
    double amount = 0,
    StockType type = StockType.market,
  })  : _symbol = symbol,
        _type = type,
        _date = date,
        _buyPrice = buyPrice,
        _sellPrice = sellPrice,
        _amount = amount;
}

enum StockType { market, user }
