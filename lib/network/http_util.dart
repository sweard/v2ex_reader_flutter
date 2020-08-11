import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:v2exreader/data/node.dart';
import 'package:v2exreader/data/reply.dart';
import 'package:v2exreader/data/topic.dart';
import 'package:v2exreader/utils/log_util.dart';

class HttpUtil {
  static const hotTopic = "https://www.v2ex.com/api/topics/hot.json";
  static const latest = "https://www.v2ex.com/api/topics/latest.json";
  static const nodes = "https://www.v2ex.com/api/nodes/all.json";
  static const replies = "https://www.v2ex.com/api/replies/show.json?topic_id=";
  static const topicByNode =
      "https://www.v2ex.com/api/topics/show.json?node_name=";

  ///获取热门主题
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

  ///获取最新主题
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

  ///获取所有节点
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

  ///获取对应节点下所有主题
  static Future<List<Topic>> loadTopicByNode(String node) async {
    final response = await http.get(topicByNode + node);
    if (response.statusCode == 200) {
      List<Topic> topics = [];
      List<dynamic> list = jsonDecode(response.body);
      list.forEach((item) {
        topics.add(Topic.fromJson(item));
      });
      return topics;
    } else {
      throw Exception("http code != 200");
    }
  }

  ///获取对应主题id下所有回复
  static Future<List<Show>> loadReplies(int id) async {
    final response = await http.get(replies + id.toString());
    if (response.statusCode == 200) {
      List<Show> replies = [];
      List<dynamic> list = jsonDecode(response.body);
      list.forEach((element) {
        replies.add(Show.fromJson(element));
      });
      Logs.d(message: "reply list $replies");
      return replies;
    } else {
      throw Exception("http code != 200");
    }
  }
}
