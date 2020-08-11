import 'package:flutter/foundation.dart';
import 'package:v2exreader/data/node.dart';
import 'package:v2exreader/data/sqlitehelper.dart';
import 'package:v2exreader/network/http_util.dart';
import 'package:v2exreader/utils/log_util.dart';

///节点
class NodeModel with ChangeNotifier {

  NodeModel() {
    Logs.d(message: "NodeModel init");
    _loadCacheOrNew();
  }

  //节点列表
  List<Node> _nodes = [];

  List<Node> getNodes() => _nodes;

  _loadCacheOrNew() async {
    List<Node> localData = await SQLiteHelper.nodes();
    Logs.d(message: "Node local data 数量-" + localData.length.toString());
    if (localData.isEmpty) {
      Logs.d(message: "加载服务器数据");
      refreshNodes();
    } else {
      Logs.d(message: "加载本地数据");
      _nodes.addAll(localData);
    }
    notifyListeners();
  }

  refreshNodes() async {
    _nodes.clear();
    List<Node> refreshData = await HttpUtil.loadAllNodes();
    SQLiteHelper.insertNodes(refreshData);
    _nodes.addAll(refreshData);
    notifyListeners();
  }
}
