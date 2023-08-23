import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

class StockHistory {
  static const String baseUrl = "https://finnhub.io/api/v1";
  static const String wsUrl = "wss://ws.finnhub.io";
  static const String _apiToken = "cj8d6q1r01qlegoku00gcj8d6q1r01qlegoku010";
  late IOWebSocketChannel channel;
  late String _symbol;
  List<double> _daily = [];
  List<double> _weekly = [];
  List<double> _monthly = [];

  String get symbol => _symbol;
  List<double> get daily => _daily;
  List<double> get weekly => _weekly;
  List<double> get monthly => _monthly;

  Future<StockHistory> init(String symbol) async {
    _symbol = symbol;

    const String wsLink = '$wsUrl?token=$_apiToken';
    try {
      channel = IOWebSocketChannel.connect(wsLink);
    } catch (e) {
      throw Exception(e);
    }

    _daily = await _getStockHistory(
      DateTime.now().subtract(const Duration(days: 364)),
      DateTime.now(),
      resolution: "D",
    );
    _weekly = await _getStockHistory(
      DateTime.now().subtract(const Duration(days: 364)),
      DateTime.now(),
      resolution: "W",
    );
    _monthly = await _getStockHistory(
      DateTime.now().subtract(const Duration(days: 331)),
      DateTime.now(),
      resolution: "M",
    );
    return this;
  }

  Future<List<double>> _getStockHistory(DateTime start, DateTime end,
      {required String resolution, int fallback = 0}) async {
    var profileLink =
        "$baseUrl/stock/candle?symbol=$_symbol&resolution=$resolution&from=${_dateToUnix(start)}&to=${_dateToUnix(end)}&token=$_apiToken";
    var resp = await http.get(Uri.parse(profileLink));

    switch (resp.statusCode) {
      case 200:
        return _getPriceFromJson(resp.body);
      case 429:
        await Future.delayed(const Duration(seconds: 1));
        fallback++;
        if (fallback < 10) {
          return _getStockHistory(start, end,
              resolution: resolution, fallback: fallback);
        } else {
          throw Exception("Symbol data timedOut: ${resp.toString()}");
        }

      default:
        throw Exception("Profile Error: $_symbol: ${resp.statusCode}");
    }
  }

  int _dateToUnix(DateTime time) {
    return time.millisecondsSinceEpoch ~/ 1000;
  }

  List<double> _getPriceFromJson(String body) {
    Map<String, dynamic> data = json.decode(body);

    return List<double>.from(data['c'].map((value) {
      return double.parse("$value");
    }));
  }
}

/*

  Future<void> open() async {
    const String wsLink = '$wsUrl?token=$_apiToken';

    if (channel.closeCode != null) return;

    // Creating a delay to not go over of rate limits
    await Future.delayed(const Duration(seconds: 1));

    //Create the WebSocket channel
    try {
      channel = IOWebSocketChannel.connect(wsLink);
    } catch (e) {
      throw Exception(e);
    }

    // Subscribing to the symbol
    channel.sink.add('{"type":"subscribe","symbol":"$_symbol"}');

    // Registering the stream listener
    channel.stream.listen((message) {
      Map<String, dynamic> jsonData = jsonDecode(message);
      if (jsonData["data"] != null) {
        for (Map<String, dynamic> stock in jsonData["data"]) {
          if (stock["s"] != _symbol) {
            throw Exception("Given json data has a bad symbol: $stock");
          }
          _daily.add(double.parse("${stock["p"]}"));
        }
        notifyListeners();
      }
    });
  }

  void close() {
    channel.sink.close();
  }

  @override
  void dispose() {
    close();
    super.dispose();
  }
 */