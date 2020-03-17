import 'package:flutter/material.dart';

import 'nodes.dart';
import 'topic_list.dart';
import '../../utils/logUtil.dart';

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
      home: HomePage(),
    );
  }
}

const int HOT_TOPIC = 0;
const int LATEST_TOPIC = 1;
const int NODE = 2;

class HomePage extends StatefulWidget {
  final TopicList _hotTopicList =
      TopicList(key: UniqueKey(), contentType: HOT_TOPIC);
  final TopicList _latestTopicList =
      TopicList(key: UniqueKey(), contentType: LATEST_TOPIC);
  final Nodes _nodes = Nodes();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final List _titles = ["最热主题", "最新主题", "节点列表"];
  List<String> kWords;
  _SearchAppBarDelegate _searchDelegate;

  String _currentTitle = _titles[0];
  int _currentType = HOT_TOPIC;

  _changeTitle(String title) {
    Logs.d(message: "onTap-$title");
    setState(() {
      _currentTitle = title;
    });
  }

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

  _drawerTitle(int index) {
    final item = _titles[index];
    return ListTile(
      title: Text(
        item,
        style: TextStyle(fontSize: 18),
      ),
      onTap: () {
        Navigator.pop(context);
        _changeTitle(item);
        _currentType = index;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    //Initializing search delegate with sorted list of English words
    _searchDelegate = _SearchAppBarDelegate(kWords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text(_currentTitle),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            _drawerHeader(),
            _drawerTitle(HOT_TOPIC),
            _drawerTitle(LATEST_TOPIC),
            _drawerTitle(NODE),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentType,
        children: <Widget>[
          widget._hotTopicList,
          widget._latestTopicList,
          widget._nodes
        ],
      ),
    );
  }
}

//Search delegate
class _SearchAppBarDelegate extends SearchDelegate<String> {
  final List<String> _words;
  final List<String> _history;

  _SearchAppBarDelegate(List<String> words)
      : _words = words,
  //pre-populated history of words
        _history = <String>['apple', 'orange', 'banana', 'watermelon'],
        super();

  // Setting leading icon for the search bar.
  //Clicking on back arrow will take control to main page
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //Take control back to previous page
        this.close(context, null);
      },
    );
  }

  // Builds page to populate search results.
  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('===Your Word Choice==='),
            GestureDetector(
              onTap: () {
                //Define your action when clicking on result item.
                //In this example, it simply closes the page
                this.close(context, this.query);
              },
              child: Text(
                this.query,
                style: Theme.of(context)
                    .textTheme
                    .display2
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Suggestions list while typing search query - this.query.
  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = this.query.isEmpty
        ? _history
        : _words.where((word) => word.startsWith(query));

    return _WordSuggestionList(
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        this.query = suggestion;
        this._history.insert(0, suggestion);
        showResults(context);
      },
    );
  }

  // Action buttons at the right of search bar.
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isNotEmpty ?
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ) : IconButton(
        icon: const Icon(Icons.mic),
        tooltip: 'Voice input',
        onPressed: () {
          this.query = 'TBW: Get input from voice';
        },

      ),
    ];
  }
}

// Suggestions list widget displayed in the search page.
class _WordSuggestionList extends StatelessWidget {
  const _WordSuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
          // Highlight the substring that matched the query.
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: textTheme.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: textTheme,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}