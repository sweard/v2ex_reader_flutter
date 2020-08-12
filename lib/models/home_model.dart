import 'package:flutter/widgets.dart';
import 'package:v2exreader/data/node.dart';
import 'package:v2exreader/data/sqlite_helper.dart';
import 'package:v2exreader/main.dart';
import 'package:v2exreader/network/http_util.dart';
import 'package:v2exreader/utils/log_util.dart';

class HomeModel with ChangeNotifier {
  HomeModel() {
    Logs.d(message: "HomeModel init");
    _loadNode();
  }

  int currentPageIndex = HOT_TOPIC;

  List titles = ["最热主题", "最新主题", "节点列表"];
  String currentTitle = '最热主题';

  //节点列表
  List<Node> _nodes = [];

  List<Node> getNodes() => _nodes;

  /// 修改标题
  selectPage(int index) {
    currentTitle = titles[index];
    currentPageIndex = index;
    notifyListeners();
  }

  _loadNode() async {
    List<Node> localData = await SQLiteHelper.nodes();
    Logs.d(message: "Node local data 数量-" + localData.length.toString());
    if (localData.isEmpty) {
      Logs.d(message: "加载服务器数据");
      refreshNodes();
    } else {
      Logs.d(message: "加载本地数据");
      _nodes.addAll(localData);
      notifyListeners();
    }
  }

  refreshNodes() async {
    _nodes.clear();
    List<Node> refreshData = await HttpUtil.loadAllNodes();
    SQLiteHelper.insertNodes(refreshData);
    _nodes.addAll(refreshData);
    notifyListeners();
  }
}