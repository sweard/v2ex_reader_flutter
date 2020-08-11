import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2exreader/data/node.dart';
import 'package:v2exreader/models/home_model.dart';
import 'package:v2exreader/screens/topics.dart';
import 'package:v2exreader/utils/log_util.dart';

///所有节点页面
class NodesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Logs.d(message: "node list  build");
    return Consumer<HomeModel>(
      builder: (context, model, child) => RefreshIndicator(
        child: Scrollbar(
          child: GridView.builder(
            itemBuilder: (context, index) => Card(
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NodeTopic(model.getNodes()[index].name),
                    ),
                  );
                },
                child: Text(
                  model.getNodes()[index].title,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: model.getNodes().length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, mainAxisSpacing: 6, childAspectRatio: 1.0),
          ),
        ),
        onRefresh: () => model.refreshNodes(),
      ),
    );
  }
}

class NodesSearchPage extends SearchDelegate<Node> {
  NodesSearchPage(this.sourceList);

  final List<Node> sourceList;

  String _searchHint = "请输入搜索内容...";

  @override
  String get searchFieldLabel => _searchHint;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = "";
            showSuggestions(context);
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
//        if (query.isEmpty) {
        close(context, null);
//        } else {
//          query = "";
//          showSuggestions(context);
//        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Node> result = [];
    for (var item in sourceList) {
      if (query.isNotEmpty &&
          item.title.toUpperCase().contains(query.toUpperCase())) {
        result.add(item);
      }
    }
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        title: Text(result[index].title),
        onTap: () {
          Logs.d(message: "result item click ${result[index].title}");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NodeTopic(result[index].name),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Node> suggest = query.isEmpty
        ? []
        : sourceList
            .where((input) =>
                input.title.toUpperCase().startsWith(query.toUpperCase()))
            .toList();
    return ListView.builder(
      itemCount: suggest.length,
      itemBuilder: (BuildContext context, int index) => InkWell(
        child: ListTile(
          title: RichText(
            text: TextSpan(
              text: suggest[index].title.substring(0, query.length),
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggest[index].title.substring(query.length),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
//          query = suggest[index].title;
//          showResults(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NodeTopic(suggest[index].name),
            ),
          );
        },
      ),
    );
  }
}
