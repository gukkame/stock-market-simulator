import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:stock_market/provider/provider_manager.dart';

import '../utils/convert.dart';
import '../utils/stock/user_stock.dart';
import '../utils/user.dart';
import 'general_api.dart';

class StockApi extends GeneralApi {
  Future<void> buyStock(BuildContext context, UserStock stock) async {
    var user = ProviderManager().getUser(context);
    await update(
      collection: "wallet",
      path: Convert.encode(user.email),
      data: {
        "total": FieldValue.increment(-(stock.price.abs())),
        "holding": FieldValue.arrayUnion([stock.data]),
      },
    );
  }

Future<void> sellStock(
    BuildContext context, double price, UserStock stock) async {
  var user = ProviderManager().getUser(context);
  var finalPrice = stock.amount * price;

  await update(
    collection: "wallet",
    path: Convert.encode(user.email),
    data: {
      "total": FieldValue.increment(finalPrice),
      "holding": FieldValue.arrayRemove([stock.data]), // Remove the specific stock data
    },
  );
}

  Future<Map<String, dynamic>> getWalletData(User user) async {
    debugPrint(Convert.encode(user.email));
    var data =
        (await readPath(collection: "wallet", path: Convert.encode(user.email)))
            .data();
    debugPrint("$data");
    return data as Map<String, dynamic>;
  }
}
