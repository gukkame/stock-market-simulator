import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../utils/stock.dart';
import 'general_api.dart';
import '../utils/user.dart';

import '../utils/convert.dart';

class StockApi extends GeneralApi {
  Future<void> buyStock(User user, Stock stock) async {
    await update(
      collection: "wallet",
      path: Convert.encode(user.email),
      data: {
        "total": FieldValue.increment(-(stock.price)),
        "holding": FieldValue.arrayUnion([stock.data]),
      },
    );
  }

  Future<void> sellStock(User user, Stock stock) async {
    await write(
      collection: "wallet",
      path: Convert.encode(user.email),
      data: {
        "total": FieldValue.increment(stock.price),
        "holding": FieldValue.arrayRemove([stock.data]),
        "history": FieldValue.arrayUnion([stock.data]),
      },
    );
  }

  Future<Map<String, dynamic>> getWalletData(User user) async {
    return (await readPath(
            collection: "wallet", path: Convert.encode(user.email)))
        .data() as Map<String, dynamic>;
  }

  Future<List<Stock>?> getWalletHistory(User user) async {
    try {
      var resp = await readPath(
        collection: "wallet",
        path: Convert.encode(user.email),
      );

      List<Stock> history = [];
      var data = (resp.data() as Map<String, dynamic>)["history"];
      for (var stock in data) {
        history.add(Stock.from(stock));
      }
      return history;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
