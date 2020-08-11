import 'package:flutter/widgets.dart';
import 'package:v2exreader/data/node.dart';
import 'package:v2exreader/data/sqlitehelper.dart';
import 'package:v2exreader/main.dart';
import 'package:v2exreader/utils/log_util.dart';

class HomeModel with ChangeNotifier {
  HomeModel() {
    Logs.d(message: "HomeModel init");
    _loadLocalNode();
  }

  int currentPageIndex = HOT_TOPIC;

  List titles = ["最热主题", "最新主题", "节点列表"];
  String currentTitle = '最热主题';

//  //话题列表
//  List<Topic> hotTopics = [];
//
//  //话题列表
//  List<Topic> latestTopics = [];
//
  //节点列表
  List<Node> nodes = [];

  /// 修改标题
  selectPage(int index) {
    currentTitle = titles[index];
    currentPageIndex = index;
    notifyListeners();
  }

  _loadLocalNode() async {
    List<Node> localData = await SQLiteHelper.nodes();
    Logs.d(message: "Node local data 数量-" + localData.length.toString());
    nodes.addAll(localData);
  }
//
//    refreshSpecificTopics(HOT_TOPIC);
//
//    refreshSpecificTopics(LATEST_TOPIC);
}

//  ///获取指定话题列表
//  List<Topic> getSpecificTopics(int type) {
//    if (type == HOT_TOPIC) {
//      return hotTopics;
//    } else {
//      return latestTopics;
//    }
//  }

//  refreshSpecificTopics(int type) async {
//    if (type == HOT_TOPIC) {
//      hotTopics.clear();
//      hotTopics.addAll(await HttpUtil.loadHotTopic());
//      Logs.d(message: "hotTopics-" + hotTopics.length.toString());
//    } else {
//      latestTopics.clear();
//      latestTopics.addAll(await HttpUtil.loadLatestTopic());
//      Logs.d(message: "latestTopics-" + latestTopics.length.toString());
//    }
//    notifyListeners();
//  }

//  refreshNodes() async {
//    nodes.clear();
//    List<Node> refreshData = await HttpUtil.loadAllNodes();
//    SQLiteHelper.insertNodes(refreshData);
//    nodes.addAll(refreshData);
//    notifyListeners();
//  }
//}
