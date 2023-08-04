import 'api.dart';

class GeneralApi extends Api {
  Future<String?> getUsername({required String email}) async {
    try {
      var resp = await readPath(collection: "users", path: email);
      return (resp.data() as Map<String, dynamic>)["name"] as String;
    } catch (e) {
      return null;
    }
  }
}
