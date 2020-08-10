import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2exreader/model/main.dart';
import 'package:v2exreader/utils/logUtil.dart';

class NodesEx extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Logs.d(message: "node list  build");
    return Consumer<MainViewModel>(
      builder: (context, model, child) => RefreshIndicator(
        child: Scrollbar(
          child: GridView.builder(
            itemBuilder: (context, index) => Card(
              child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    model.nodes[index].title,
                    textAlign: TextAlign.center,
                  )),
            ),
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: model.nodes.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, mainAxisSpacing: 6, childAspectRatio: 1.0),
          ),
        ),
        onRefresh: () => model.refreshNodes(),
      ),
    );
  }

}

class NodesSearchPage extends SearchDelegate<String>{

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return null;
  }

}

//class Nodes extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => _NodesState();
//}

//class _NodesState extends State<Nodes> {
//  MainViewModel _mainViewModel = MainViewModel.getInstance();
//
//  //节点列表
//  List<Node> _nodes;
//
//  _refreshData() async {
//    _mainViewModel.refreshNodes();
//    setState(() {});
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    _nodes = _mainViewModel.nodes;
//    _mainViewModel.loadLocalNodesIfHas();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return RefreshIndicator(
//      child: Scrollbar(
//        child: GridView.builder(
//          itemBuilder: (context, index) => Card(
//            child: FlatButton(
//                onPressed: () {},
//                child: Text(
//                  _nodes[index].title,
//                  textAlign: TextAlign.center,
//                )),
//          ),
//          physics: AlwaysScrollableScrollPhysics(),
//          itemCount: _nodes.length,
//          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//              crossAxisCount: 4, mainAxisSpacing: 6, childAspectRatio: 1.0),
//        ),
//      ),
//      onRefresh: () => _refreshData(),
//    );
//  }
//}
