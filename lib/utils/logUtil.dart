import 'package:flutter/cupertino.dart';

class Logs {
  static const defaultTag = "v2ex_Tag";

  static d({String tag, @required String message}) {
    if (tag == null) {
      print(defaultTag + ":$message");
    } else {
      print(tag + ":$message");
    }
  }
}
