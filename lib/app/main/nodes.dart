import 'package:flutter/material.dart';
import 'package:v2exreader/app/main/MainViewModel.dart';
import 'package:v2exreader/data/SQLiteHelper.dart';
import 'package:v2exreader/data/model/Node.dart';
import 'package:v2exreader/network/http_util.dart';

import '../../utils/logUtil.dart';

class Nodes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NodesState();
}

class _NodesState extends State<Nodes> {
  MainViewModel _mainViewModel = MainViewModel.getInstance();

  //节点列表
  List<Node> _nodes;

  _refreshData() async {
    _mainViewModel.refreshNodes();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _nodes = _mainViewModel.nodes;
    _mainViewModel.loadLocalNodesIfHas();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Scrollbar(
        child: GridView.builder(
          itemBuilder: (context, index) => Card(
            child: FlatButton(
                onPressed: () {},
                child: Text(
                  _nodes[index].title,
                  textAlign: TextAlign.center,
                )),
          ),
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: _nodes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 6, childAspectRatio: 1.0),
        ),
      ),
      onRefresh: () => _refreshData(),
    );
  }
}
