import 'package:flutter/cupertino.dart';
import 'package:stock_market/utils/stock/stock_trade_data.dart';
import 'package:stock_market/utils/stock/symbol_profile.dart';

class MarketStock {
  final StockTradeData _data;
  final SymbolProfile _profile;

  String get symbol => _data.symbol;
  int get date => _data.time;
  double get buyPrice => (_data.price * 100).round() / 100;
  double get sellPrice => ((_data.price *0.99) * 100).round() / 100;

  double get volume => _data.volume;
  String get image => _profile.logo;
  String get name => _profile.name;
  String get currency => _profile.currency;

  void updateFromJson(Map<String, dynamic> json) {
    _data.updateFromJson(json);
  }

  void printStock() {
    debugPrint(toString());
  }

  @override
  String toString() {
    return "${_data.toString()} ${_profile.toString()}";
  }

  MarketStock({
    required StockTradeData data,
    required SymbolProfile profile,
  })  : _data = data,
        _profile = profile;
}
