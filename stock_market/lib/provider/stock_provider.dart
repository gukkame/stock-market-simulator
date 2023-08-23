import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stock_market/utils/stock/market_stock.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;

import '../utils/stock/symbol_profile.dart';
import '../utils/stock/stock_trade_data.dart';

var test =
    "https://finnhub.io/api/v1/quote?symbol=AAPL&token=cj8d6q1r01qlegoku00gcj8d6q1r01qlegoku010";

class StockProvider with ChangeNotifier {
  static const String baseUrl = "https://finnhub.io/api/v1";
  static const String wsUrl = "wss://ws.finnhub.io";
  static const String _apiToken = "cj8d6q1r01qlegoku00gcj8d6q1r01qlegoku010";
  late IOWebSocketChannel channel;
  Timer? subscriptionTimer;
  bool isWebSocketConnected = false;
  Map<String, MarketStock> stocks = {};
  static const List<String> symbols = [
    'AAPL',
    'MSFT',
    'AMZN',
    'NVDA',
    'TSLA',
    'GOOGL',
    'META',
    'GOOG',
    'BRK.B',
    'UNH',
    'JNJ',
    'JPM',
    'XOM',
    'V',
    'LLY',
    'PG',
    'AVGO',
    'MA',
    'HD',
    'MRK',
  ];

  Future<void> init() async {
    debugPrint("Initializing stock websocket connection...");
    if (stocks.isNotEmpty) return;

    // Create the WebSocket channel
    const String wsLink = '$wsUrl?token=$_apiToken';
    try {
      channel = IOWebSocketChannel.connect(wsLink);
    } catch (e) {
      throw Exception(e);
    }

    // Create the SymbolWebsocket object and subscribe to the symbols
    for (var symbol in symbols) {
      SymbolProfile profile = await _getSymbolProfile(symbol);
      StockTradeData stock = await _getStockTradeData(symbol);
      stocks[symbol] = MarketStock(data: stock, profile: profile);

      await Future.delayed(const Duration(milliseconds: 200));

      channel.sink.add('{"type":"subscribe","symbol":"$symbol"}');
      debugPrint(stocks[symbol].toString());
    }

    _setListener();
    notifyListeners();

    debugPrint("WebSocket connection status: $isWebSocketConnected");
  }

  Future<SymbolProfile> _getSymbolProfile(String symbol,
      [int fallback = 0]) async {
    var profileLink = "$baseUrl/stock/profile2?symbol=$symbol&token=$_apiToken";
    var resp = await http.get(Uri.parse(profileLink));

    switch (resp.statusCode) {
      case 200:
        return SymbolProfile.fromJson(json.decode(resp.body));

      case 429:
        await Future.delayed(const Duration(seconds: 1));
        fallback++;
        if (fallback < 10) {
          return _getSymbolProfile(symbol, fallback);
        } else {
          throw Exception("Symbol data timedOut: ${resp.toString()}");
        }

      default:
        throw Exception("Profile Error: $symbol: ${resp.statusCode}");
    }
  }

  Future<StockTradeData> _getStockTradeData(String symbol,
      [int fallback = 0]) async {
    var stock = StockTradeData(symbol: symbol);
    var stockLink = "$baseUrl/quote?symbol=$symbol&token=$_apiToken";
    var resp = await http.get(Uri.parse(stockLink));

    switch (resp.statusCode) {
      case 200:
        stock.setInitJson(json.decode(resp.body));
        return stock;

      case 429:
        await Future.delayed(const Duration(seconds: 1));
        fallback++;
        if (fallback < 10) {
          return _getStockTradeData(symbol, fallback);
        } else {
          throw Exception("Symbol data timed out: ${resp.toString()}");
        }

      default:
        throw Exception("Symbol data error: $symbol: ${resp.toString()}");
    }
  }

  void _setListener() {
    channel.stream.listen(
      (message) {
        Map<String, dynamic> jsonData = jsonDecode(message);
        if (jsonData["data"] != null) {
          for (Map<String, dynamic> stock in jsonData["data"]) {
            if (!stock.containsKey("s") || stock["s"] is! String) {
              throw Exception(
                  "Given json data has a bad symbol: $stock ${!stock.containsKey("s")} ${stock["s"] is! String}");
            }
            stocks[stock["s"]]?.updateFromJson(stock);
          }
          // debugPrint("Pinged");
          notifyListeners();
        }
      },
      onError: (error) {
        debugPrint(error.toString());
        Future.delayed(const Duration(seconds: 1));
        debugPrint("setting new listener");
        _setListener();
      },
    );
  }

  void open() {
    debugPrint("close code ${channel.closeCode}");
    if (channel.closeCode == null) return;

    // Create the WebSocket channel
    const String wsLink = '$wsUrl?token=$_apiToken';
    try {
      channel = IOWebSocketChannel.connect(wsLink);
    } catch (e) {
      throw Exception(e);
    }

    for (var symbol in symbols) {
      channel.sink.add('{"type":"subscribe","symbol":"$symbol"}');
    }
    // // Start sending subscription messages at a controlled rate
    // subscriptionTimer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
    //   _checkWebSocketConnection();

    // });

    _setListener();

    // Notify listeners that the WebSocket connection has been opened
    notifyListeners();
  }

  // void _checkWebSocketConnection() {
  //   if (!isWebSocketConnected || (channel.closeCode != null)) {
  //     reset();
  //   }
  // }

  void close() {
    // subscriptionTimer?.cancel();
    channel.sink.close();
  }

  void reset() async {
    close();
    await Future.delayed(const Duration(seconds: 2));
    open();
  }

  void clear() {
    stocks.clear();
    channel.sink.close();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }
}
