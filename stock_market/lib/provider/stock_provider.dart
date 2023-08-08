import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stock_market/utils/stock/market_stock.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;

import '../utils/stock/symbol_profile.dart';
import '../utils/stock/stock_trade_data.dart';

class StockProvider with ChangeNotifier {
  static const String baseUrl = "https://finnhub.io/api/v1";
  static const String wsUrl = "wss://ws.finnhub.io";
  static const String apiToken = "cj8d6q1r01qlegoku00gcj8d6q1r01qlegoku010";
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
  late IOWebSocketChannel channel;
  Map<String, MarketStock> stocks = {};
  bool _isRateLimited = false;

  Future<void> init() async {
    debugPrint("INIT STOCKS");
    // Create the WebSocket channel
    const String wsLink = '$wsUrl?token=$apiToken';
    try {
      channel = IOWebSocketChannel.connect(wsLink);
    } catch (e) {
      await Future.delayed(const Duration(seconds: 1));
      channel = IOWebSocketChannel.connect(wsLink);
    }

    // Create the SymbolWebsocket object and
    // subscribe to the symbols
    stocks.clear();
    for (var symbol in symbols) {
      // Getting the profile
      SymbolProfile profile = SymbolProfile();
      // var profileLink =
      //     "$baseUrl/stock/profile2?symbol=$symbol&token=$apiToken";
      // var resp = await http.get(Uri.parse(profileLink));
      // if (resp.statusCode == 200) {
      //   profile = SymbolProfile.fromJson(json.decode(resp.body));
      //   debugPrint(profile.toString());
      // } else {
      //   debugPrint("$resp");
      //   throw Exception(
      //       "couldn't get the profile for $symbol: ${resp.statusCode}");
      // }
      // await Future.delayed(const Duration(seconds: 1));

      // Creating StockTradeData
      var stock = StockTradeData(symbol: symbol);
      // var stockLink = "$baseUrl/quote?symbol=$symbol&token=$apiToken";
      // var stockResp = await http.get(Uri.parse(stockLink));
      // if (stockResp.statusCode == 200) {
      //   stock.setInitJson(json.decode(stockResp.body));
      //   debugPrint(stock.toString());
      // } else {
      //   debugPrint("$stockResp");
      //   throw Exception(
      //       "couldn't get the stock for $symbol: ${stockResp.statusCode}");
      // }
      // await Future.delayed(const Duration(seconds: 1));


      // Adding symbol to websocket
      channel.sink.add('{"type":"subscribe","symbol":"$symbol"}');

      // Creating market stock
      stocks[symbol] = MarketStock(data: stock, profile: profile);
    }

    // Handle received messages
    channel.stream.listen((message) {
      Map<String, dynamic> jsonData = jsonDecode(message);
      if (jsonData["data"] != null) {
        for (Map<String, dynamic> stock in jsonData["data"]) {
          if (!stock.containsKey("s") || stock["s"] is! String) {
            throw Exception(
                "Given json data has a bad symbol: $stock ${!stock.containsKey("s")} ${stock["s"] is! String}");
          }
          stocks[stock["s"]]?.updateFromJson(stock);
          stocks[stock["s"]]?.printStock();
        }
        notifyListeners();
      }
    });

    notifyListeners();
  }

  void _handleRateLimit() {
    const String wsLink = '$wsUrl?token=$apiToken';
    _isRateLimited = true;

    // Pause the WebSocket subscription temporarily
    channel.sink.close();

    // Wait for a while (e.g., 1 minute) before resuming the subscription
    Future.delayed(const Duration(minutes: 1), () {
      _isRateLimited = false;

      // Reopen the WebSocket subscription
      channel = IOWebSocketChannel.connect(wsLink);
      for (var symbol in symbols) {
        // ...
        channel.sink.add('{"type":"subscribe","symbol":"$symbol"}');
        // ...
      }
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
