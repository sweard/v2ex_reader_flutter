import 'package:v2exreader/data/SQLiteHelper.dart';
import 'package:v2exreader/data/model/Node.dart';
import 'package:v2exreader/data/model/Topic.dart';
import 'package:v2exreader/network/http_util.dart';
import 'package:v2exreader/utils/logUtil.dart';

class MainViewModel {
  //话题列表
  List<Topic> hotTopics = [];

  //话题列表
  List<Topic> latestTopics = [];

  //节点列表
  List<Node> nodes = [];

  static MainViewModel instance;

  static MainViewModel getInstance() {
    if (instance == null) {
      instance = MainViewModel();
    }
    return instance;
  }

  Future<void> refreshHotTopics() async {
    hotTopics.clear();
    hotTopics.addAll(await HttpUtil.loadHotTopic());
    Logs.d(message: "hotTopics-" + hotTopics.length.toString());
  }

  Future<void> refreshLatestTopics() async {
    latestTopics.clear();
    latestTopics.addAll(await HttpUtil.loadLatestTopic());
    Logs.d(message: "latestTopics-" + latestTopics.length.toString());
  }

  loadLocalNodesIfHas() async {
    List<Node> localData = await SQLiteHelper.nodes();
    Logs.d(message: "Node数量-" + localData.length.toString());
    if (localData.isEmpty) {
      Logs.d(message: "加载服务器数据");
      refreshNodes();
    } else {
      Logs.d(message: "加载本地数据");
      nodes.addAll(localData);
    }
  }

  Future<void> refreshNodes() async {
    nodes.clear();
    List<Node> refreshData = await HttpUtil.loadAllNodes();
    SQLiteHelper.insertNodes(refreshData);
    nodes.addAll(refreshData);
  }

  void cleared() {
    hotTopics.clear();
    latestTopics.clear();
    nodes.clear();
  }
}
