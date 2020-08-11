import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2exreader/main.dart';
import 'package:v2exreader/models/home_model.dart';
import 'package:v2exreader/screens/nodes.dart';
import 'package:v2exreader/utils/log_util.dart';

import 'topic_list.dart';

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
    return Consumer<HomeModel>(
      builder: (_, model, __) => ListTile(
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
      create: (context) => HomeModel(),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Consumer<HomeModel>(
            builder: (context, model, child) {
              Logs.d(message: "model change");
              return model.getTitle;
            },
          ),
          actions: <Widget>[
            Consumer<HomeModel>(
              builder: (context, model, child) {
                return Visibility(
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Logs.d(message: "search button click");
                      showSearch(
                          context: context,
                          delegate: NodesSearchPage(model.nodes));
                    },
                  ),
                  visible: model.currentPageIndex == NODE,
                );
              },
            )
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
        body: Consumer<HomeModel>(
          builder: (context, model, child) {
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