import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2exreader/app/main/MainViewModel.dart';

import 'nodes.dart';
import 'topic_list.dart';
import '../../utils/logUtil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainViewModel(),
      child: MaterialApp(
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: HomePageEx(),
      ),
    );
  }
}

const int HOT_TOPIC = 0;
const int LATEST_TOPIC = 1;
const int NODE = 2;

class HomePageEx extends StatelessWidget {
  final TopicListEx _hotTopicList =
      TopicListEx(key: UniqueKey(), contentType: HOT_TOPIC);
  final TopicListEx _latestTopicList =
      TopicListEx(key: UniqueKey(), contentType: LATEST_TOPIC);
  final NodesEx _nodes = NodesEx();

  _drawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(color: Colors.blue),
      child: Center(
        child: Text(
          "V2EX",
          style: TextStyle(fontSize: 36, color: Colors.white),
        ),
      ),
    );
  }

  _drawerTitle(BuildContext context, int index) {
    return ListTile(
      title: Consumer<MainViewModel>(
        builder: (_, model, child) => Text(
          model.titles[index],
          style: TextStyle(fontSize: 18),
        ),
      ),
      onTap: () {
        Provider.of<MainViewModel>(context, listen: false).changeTitle(index);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Logs.d(message: "home build");
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Consumer<MainViewModel>(
          builder: (context, model, child) => Text(
            model.title,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            _drawerHeader(),
            _drawerTitle(context, HOT_TOPIC),
            _drawerTitle(context, LATEST_TOPIC),
            _drawerTitle(context, NODE),
          ],
        ),
      ),
      body: Consumer<MainViewModel>(
        builder: (context, model, child) => IndexedStack(
          index: model.currentPageIndex,
          children: <Widget>[_hotTopicList, _latestTopicList, _nodes],
        ),
      ),
    );
  }
}

//class HomePage extends StatefulWidget {
//  final TopicList _hotTopicList =
//      TopicList(key: UniqueKey(), contentType: HOT_TOPIC);
//  final TopicList _latestTopicList =
//      TopicList(key: UniqueKey(), contentType: LATEST_TOPIC);
//  final Nodes _nodes = Nodes();
//
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//  static final List _titles = ["最热主题", "最新主题", "节点列表"];
//
//  String _currentTitle = _titles[0];
//  int _currentType = HOT_TOPIC;
//
//  _changeTitle(String title) {
//    Logs.d(message: "onTap-$title");
//    setState(() {
//      _currentTitle = title;
//    });
//  }
//
//  _drawerHeader() {
//    return DrawerHeader(
//      decoration: BoxDecoration(color: Colors.blue),
//      child: Center(
//        child: Text(
//          "V2EX",
//          style: TextStyle(fontSize: 36, color: Colors.white),
//        ),
//      ),
//    );
//  }
//
//  _drawerTitle(int index) {
//    final item = _titles[index];
//    return ListTile(
//      title: Text(
//        item,
//        style: TextStyle(fontSize: 18),
//      ),
//      onTap: () {
//        Navigator.pop(context);
//        _changeTitle(item);
//        _currentType = index;
//      },
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        titleSpacing: 0.0,
//        title: Text(_currentTitle),
//      ),
//      drawer: Drawer(
//        child: ListView(
//          children: <Widget>[
//            _drawerHeader(),
//            _drawerTitle(HOT_TOPIC),
//            _drawerTitle(LATEST_TOPIC),
//            _drawerTitle(NODE),
//          ],
//        ),
//      ),
//      body: IndexedStack(
//        index: _currentType,
//        children: <Widget>[
//          widget._hotTopicList,
//          widget._latestTopicList,
//          widget._nodes
//        ],
//      ),
//    );
//  }
//}
