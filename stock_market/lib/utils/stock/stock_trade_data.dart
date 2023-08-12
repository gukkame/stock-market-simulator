class StockTradeData {
  final String symbol;
  double price;
  int time;
  double volume;

  StockTradeData({
    required this.symbol,
    this.price = 0,
    this.time = 0,
    this.volume = 0,
  });

  StockTradeData setInitJson(Map<String, dynamic> json) {
    price = double.parse("${json['c']}");
    time = json['t'];
    return this;
  }

  void updateFromJson(Map<String, dynamic> json) {
    if (symbol != json['s']) {
      throw Exception(
          "tried to update the wrong symbol: $symbol != ${json['s']}");
    }
    price = double.parse("${json['p']}");
    time = json['t'];
    volume = double.parse("${json['v']}");
  }

  @override
  String toString() {
    return "Symbol: $symbol, Price: $price, Time: $time, Volume: $volume.";
  }
}
