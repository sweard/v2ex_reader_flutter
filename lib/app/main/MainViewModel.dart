import 'package:flutter/widgets.dart';
import 'package:v2exreader/app/main/main.dart';
import 'package:v2exreader/data/SQLiteHelper.dart';
import 'package:v2exreader/data/Node.dart';
import 'package:v2exreader/data/Topic.dart';
import 'package:v2exreader/network/http_util.dart';
import 'package:v2exreader/utils/logUtil.dart';

class MainViewModel with ChangeNotifier {
  MainViewModel() {
    loadAll();
  }

  int currentPageIndex = 0;

  static List titles = ["最热主题", "最新主题", "节点列表"];
  String title = '最热主题';

  //话题列表
  List<Topic> hotTopics = [];

  //话题列表
  List<Topic> latestTopics = [];

  //节点列表
  List<Node> nodes = [];

  /// 修改标题
  void changeTitle(int index) {
    title = titles[index];
    currentPageIndex = index;
    notifyListeners();
  }

  Widget get getTitle {
    return Text(title, style: TextStyle(fontSize: 18));
  }

  loadAll() async {
    List<Node> localData = await SQLiteHelper.nodes();
    Logs.d(message: "Node local data 数量-" + localData.length.toString());
    if (localData.isEmpty) {
      Logs.d(message: "加载服务器数据");
      refreshNodes();
    } else {
      Logs.d(message: "加载本地数据");
      nodes.addAll(localData);
    }

    refreshSpecificTopics(HOT_TOPIC);

    refreshSpecificTopics(LATEST_TOPIC);
  }

  ///获取指定话题列表
  List<Topic> getSpecificTopics(int type) {
    if (type == HOT_TOPIC) {
      return hotTopics;
    } else {
      return latestTopics;
    }
  }

  refreshSpecificTopics(int type) async {
    if (type == HOT_TOPIC) {
      hotTopics.clear();
      hotTopics.addAll(await HttpUtil.loadHotTopic());
      Logs.d(message: "hotTopics-" + hotTopics.length.toString());
    } else {
      latestTopics.clear();
      latestTopics.addAll(await HttpUtil.loadLatestTopic());
      Logs.d(message: "latestTopics-" + latestTopics.length.toString());
    }
    notifyListeners();
  }

//  _getNodes() async {
//    List<Node> localData = await SQLiteHelper.nodes();
//    Logs.d(message: "Node local data 数量-" + localData.length.toString());
//    if (localData.isEmpty) {
//      Logs.d(message: "加载服务器数据");
//      refreshNodes();
//    } else {
//      Logs.d(message: "加载本地数据");
//      nodes.addAll(localData);
//    }
//  }

  refreshNodes() async {
    nodes.clear();
    List<Node> refreshData = await HttpUtil.loadAllNodes();
    SQLiteHelper.insertNodes(refreshData);
    nodes.addAll(refreshData);
    notifyListeners();
  }
}
