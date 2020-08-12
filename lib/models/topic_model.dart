import 'package:flutter/cupertino.dart';
import 'package:v2exreader/data/topic.dart';
import 'package:v2exreader/main.dart';
import 'package:v2exreader/network/http_util.dart';
import 'package:v2exreader/utils/log_util.dart';

///话题，外层数据
class TopicModel with ChangeNotifier {
  TopicModel() {
    Logs.d(message: "TopicModel init");
//    _loadAll();
  }

  //热门话题列表
  List<Topic> _hotTopics = [];

  //最新话题列表
  List<Topic> _latestTopics = [];

  ///获取指定话题列表
  List<Topic> getSpecificTopics(int type) {
    if (type == HOT_TOPIC) {
      return _hotTopics;
    } else {
      return _latestTopics;
    }
  }

//  _loadAll() async {
//    _hotTopics.clear();
//    _hotTopics.addAll(await HttpUtil.loadHotTopic());
//    Logs.d(message: "hotTopics-" + _hotTopics.length.toString());
//
//    _latestTopics.clear();
//    _latestTopics.addAll(await HttpUtil.loadLatestTopic());
//    Logs.d(message: "latestTopics-" + _hotTopics.length.toString());
//
//    notifyListeners();
//  }

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

class NodeTopicModel with ChangeNotifier {

  NodeTopicModel(this._node) {
    refreshTopicByNode();
  }

  final String _node;

  //节点下所有话题
  List<Topic> _nodeTopics = [];

  getNodeTopics() => _nodeTopics;

  refreshTopicByNode() async {
    _nodeTopics.clear();
    _nodeTopics.addAll(await HttpUtil.loadTopicByNode(_node));
    notifyListeners();
  }
}
