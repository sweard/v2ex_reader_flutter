import 'package:flutter/cupertino.dart';
import 'package:v2exreader/data/topic.dart';
import 'package:v2exreader/main.dart';
import 'package:v2exreader/network/http_util.dart';
import 'package:v2exreader/utils/logUtil.dart';

///话题，外层数据
class TopicModel with ChangeNotifier{
  //热门话题列表
  List<Topic> _hotTopics = [];

  //最新话题列表
  List<Topic> _latestTopics = [];

  refreshSpecificTopics(int type) async {
    if (type == HOT_TOPIC) {
      _hotTopics.clear();
      _hotTopics.addAll(await HttpUtil.loadHotTopic());
      Logs.d(message: "hotTopics-" + _hotTopics.length.toString());
    } else {
      _latestTopics.clear();
      _latestTopics.addAll(await HttpUtil.loadLatestTopic());
      Logs.d(message: "latestTopics-" + _hotTopics.length.toString());
    }
    notifyListeners();
  }
}