import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:v2exreader/data/Node.dart';
import 'package:v2exreader/data/Topic.dart';

class HttpUtil {
  static const hotTopic = "https://www.v2ex.com/api/topics/hot.json";
  static const latest = "https://www.v2ex.com/api/topics/latest.json";
  static const nodes = "https://www.v2ex.com/api/nodes/all.json";

  static Future<List<Topic>> loadHotTopic() async {
    final response = await http.get(hotTopic);
    if (response.statusCode == 200) {
      List<Topic> hotTopics = [];
      List<dynamic> list = jsonDecode(response.body);
      list.forEach((item) {
        hotTopics.add(Topic.fromJson(item));
      });
      print(hotTopics[0].url);
      return hotTopics;
    } else {
      throw Exception("http code != 200");
    }
  }

  static Future<List<Topic>> loadLatestTopic() async {
    final response = await http.get(latest);
    if (response.statusCode == 200) {
      List<Topic> hotTopics = [];
      List<dynamic> list = jsonDecode(response.body);
      list.forEach((item) {
        hotTopics.add(Topic.fromJson(item));
      });
      print(hotTopics[0].url);
      return hotTopics;
    } else {
      throw Exception("http code != 200");
    }
  }

  static Future<List<Node>> loadAllNodes() async {
    final response = await http.get(nodes);
    if (response.statusCode == 200) {
      List<Node> nodes = [];
      List<dynamic> list = jsonDecode(response.body);
      list.forEach((item) {
        nodes.add(Node.fromJson(item));
      });
      return nodes;
    } else {
      throw Exception("http code != 200");
    }
  }
}
