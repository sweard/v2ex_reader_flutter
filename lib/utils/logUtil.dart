import 'package:flutter/cupertino.dart';

class Logs {
  static const defaultTag = "v2ex_Tag";

  static d({String tag, @required Object message}) {
    if (tag == null) {
      print(defaultTag + ":$message");
    } else {
      print(tag + ":$message");
    }
  }
}
