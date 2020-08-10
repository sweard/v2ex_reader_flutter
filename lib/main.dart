import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2exreader/model/main.dart';

import 'screens/nodes.dart';
import 'screens/topic_list.dart';
import 'utils/logUtil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    return Consumer<MainViewModel>(
      builder: (_, model, __) =>
          ListTile(
            title: Text(
              model.titles[index],
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              model.selectPage(index);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pop(context);
              });
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Logs.d(message: "home build");

    return ChangeNotifierProvider(
      create: (context) => MainViewModel(),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Consumer<MainViewModel>(
            builder: (context, model, child) {
              Logs.d(message: "model change");
              return model.getTitle;
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: null);
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _drawerHeader(),
              _drawerTitle(context, HOT_TOPIC),
              _drawerTitle(context, LATEST_TOPIC),
              _drawerTitle(context, NODE),
            ],
          ),
        ),
        body: Consumer<MainViewModel>(
          builder: (context, model, child) {
            Logs.d(message: Scaffold
                .of(context)
                .isDrawerOpen);

            return IndexedStack(
              index: model.currentPageIndex,
              children: <Widget>[_hotTopicList, _latestTopicList, _nodes],
            );
          },
        ),
      ),
    );
  }
}
