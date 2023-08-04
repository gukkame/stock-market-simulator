import 'package:flutter/cupertino.dart';
import '../utils/convert.dart';
import 'general_api.dart';

class UserApi extends GeneralApi {
  Future<bool> registerNewUser(
      {required String email,
      required String name,
      required String password}) async {
    try {
      await write(
        collection: "users",
        path: email,
        data: {"email": Convert.encode(email), "name": name},
      );
      await write(
        collection: "wallet",
        path: Convert.encode(email),
        data: {"total": 1000000, "holding": [], "history": []},
      );

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
