import 'package:cloud_firestore/cloud_firestore.dart';

class UserStock {
  final String _symbol;
  final Timestamp _date;
  double _value = 0;
  double _amount = 0;

  String get symbol => _symbol;
  Timestamp get date => _date;
  double get amount => _amount;
  dynamic get price => _amount * _value;

  Map<String, dynamic> get data {
    return {
      "symbol": symbol,
      "date": date,
      "value": _value,
      "amount": amount,
    };
  }

  factory UserStock.from(Map<String, dynamic> data) {
    return UserStock(
      symbol: data["symbol"],
      date: data["date"],
      value: data["value"],
      amount: data["amount"],
    );
  }

  UserStock({
    required String symbol,
    required Timestamp date,
    required double value,
    required double amount,
  })  : _symbol = symbol,
        _date = date,
        _value = value,
        _amount = amount;
}
