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
        data: {"email": email, "name": name},
      );
      await write(
        collection: "wallet",
        path: Convert.encode(email),
        data: {"total": 1000000, "holding": []},
      );

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<String?> getUsername({required String email}) async {
    try {
      var resp = await readPath(collection: "users", path: email);
      return (resp.data() as Map<String, dynamic>)["name"] as String;
    } catch (e) {
      return null;
    }
  }
}
