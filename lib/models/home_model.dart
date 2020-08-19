import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:v2ex_reader/data/node.dart';
import 'package:v2ex_reader/data/sqlite_helper.dart';
import 'package:v2ex_reader/main.dart';
import 'package:v2ex_reader/network/http_util.dart';
import 'package:v2ex_reader/utils/log_util.dart';

class HomeModel with ChangeNotifier {
  HomeModel() {
    Logs.d(message: "HomeModel init");
    _loadLocalNode();
    _loadCacheImageFile();
  }

  int currentPageIndex = HOT_TOPIC;

  List titles = ["最热主题", "最新主题", "节点列表"];
  String currentTitle = '最热主题';

  String imageFileName;
  File imageFile;

  //节点列表
  List<Node> _nodes = [];

  List<Node> getNodes() => _nodes;

  /// 修改标题
  selectPage(int index) {
    currentTitle = titles[index];
    currentPageIndex = index;
    notifyListeners();
  }

  _loadLocalNode() async {
    List<Node> localData = await SQLiteHelper.nodes();
    Logs.d(message: "load local Node count -" + localData.length.toString());
    _nodes.addAll(localData);
    if (_nodes.isNotEmpty) {
      notifyListeners();
    }
  }

  _loadCacheImageFile() async {
    final dir = Directory((await getTemporaryDirectory()).path);
    imageFile =
        dir.listSync().firstWhere((element) => element.path.contains("v2ex"));
    imageFileName = basename(imageFile.path);
    Logs.d(message: "image file name:$imageFileName");
    notifyListeners();
  }

  refreshImageFile(String fileName) async {
    // Construct the path where the image should be saved using the
    // pattern package.
    final imagePath = join(
      // Store the picture in the temp directory.
      // Find the temp directory using the `path_provider` plugin.
      (await getTemporaryDirectory()).path,
      fileName,
    );
    imageFile = File(imagePath);
    imageFileName = fileName;
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
