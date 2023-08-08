import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/convert.dart';
import '../utils/stock/user_stock.dart';
import '../utils/user.dart';
import 'general_api.dart';

class StockApi extends GeneralApi {
  Future<void> buyStock(User user, UserStock stock) async {
    await update(
      collection: "wallet",
      path: Convert.encode(user.email),
      data: {
        "total": FieldValue.increment(-(stock.price)),
        "holding": FieldValue.arrayUnion([stock.data]),
      },
    );
  }

  Future<void> sellStock(User user, UserStock stock) async {
    await write(
      collection: "wallet",
      path: Convert.encode(user.email),
      data: {
        "total": FieldValue.increment(stock.price),
        "holding": FieldValue.arrayRemove([stock.data]),
      },
    );
  }

  Future<Map<String, dynamic>> getWalletData(User user) async {
    return (await readPath(
            collection: "wallet", path: Convert.encode(user.email)))
        .data() as Map<String, dynamic>;
  }
}
