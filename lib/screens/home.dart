import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2exreader/main.dart';
import 'package:v2exreader/models/home_model.dart';
import 'package:v2exreader/models/topic_model.dart';
import 'package:v2exreader/screens/nodes.dart';
import 'package:v2exreader/screens/topics.dart';
import 'package:v2exreader/utils/log_util.dart';

///主页，通过drawer切换子界面
class HomePageEx extends StatelessWidget {
  final TopicPage _hotTopicList =
      TopicPage(key: UniqueKey(), contentType: HOT_TOPIC);
  final TopicPage _latestTopicList =
      TopicPage(key: UniqueKey(), contentType: LATEST_TOPIC);
  final NodesPage _nodes = NodesPage();

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeModel()),
        ChangeNotifierProvider(create: (context) => TopicModel())
      ],
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Consumer<HomeModel>(
            builder: (context, model, child) {
              Logs.d(message: "model change");
              return Text(model.currentTitle, style: TextStyle(fontSize: 18));
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
                          delegate: NodesSearchPage(model.getNodes()));
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
