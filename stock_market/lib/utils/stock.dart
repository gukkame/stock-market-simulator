import 'package:cloud_firestore/cloud_firestore.dart';

class Stock {
  final String _symbol;
  final Timestamp _date;
  final double _value;
  final double _amount;

  String get symbol => _symbol;
  Timestamp get date => _date;
  double get value => _value;
  double get amount => _amount;
  double get price => value * amount;

  Map<String, dynamic> get data {
    return {
      "symbol": symbol,
      "date": date,
      "value": value,
      "amount": amount,
    };
  }

  factory Stock.from(Map<String, dynamic> data) {
    return Stock(
      data["symbol"],
      data["date"],
      data["value"],
      data["amount"],
    );
  }

  Stock(
    String symbol,
    Timestamp date,
    double value,
    double amount,
  )   : _symbol = symbol,
        _date = date,
        _value = value,
        _amount = amount;
}
