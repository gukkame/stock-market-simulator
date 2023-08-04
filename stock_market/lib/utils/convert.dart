import 'dart:convert';

class Convert {
  static String encode(String data) => base64Url.encode(utf8.encode(data));
  static String decode(String data) => utf8.decode(base64Url.decode(data));
}