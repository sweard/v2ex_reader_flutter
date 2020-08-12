import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2exreader/models/topic_model.dart';
import 'package:v2exreader/screens/member_detail.dart';
import 'package:v2exreader/screens/replies.dart';
import 'package:v2exreader/utils/log_util.dart';

import '../data/topic.dart';
import '../transparent_image.dart';

///最新主题，最热主题共用界面
///contentType HOT_TOPIC LATEST_TOPIC
class TopicPage extends StatelessWidget {
  TopicPage({Key key, @required this.contentType}) : super(key: key);
  final int contentType;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  //文本间分割符
  final Text _divider = Text("-");

//列表item
  _item(BuildContext context, Topic topic) {
    //作者头像
    Padding _avatar = Padding(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
      child: ClipRRect(
        child: FadeInImage.memoryNetwork(
            width: 48,
            height: 48,
            fit: BoxFit.cover,
            placeholder: kTransparentImage,
            image: topic.member.avatarLarge),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    //内容
    Expanded _content = Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 8),
          Text(
            topic.title,
            softWrap: true,
          ),
          SizedBox(height: 8),
          Row(
            children: <Widget>[
              ButtonTheme(
                minWidth: 0,
                height: 24,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: FlatButton(
                  child: Text(topic.node.name),
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NodeTopic(topic.node.name),
                      ),
                    );
                  },
                ),
              ),
              _divider,
              ButtonTheme(
                minWidth: 0,
                height: 24,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: FlatButton(
                  child: Text(topic.member.username),
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MemberDetailPage(topic.member.username),
                      ),
                    );
                  },
                ),
              ),
              _divider,
              Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: Text(
                    topic.fromNowTerm(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );

    return GestureDetector(
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _avatar,
            _content,
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: Text(
                topic.replies.toString(),
                style: TextStyle(color: Colors.black54),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TopicContent(topic.id, topic.title, topic.content)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Logs.d(message: "topic list $contentType build");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _refreshIndicatorKey.currentState.show();
    });

    return Consumer<TopicModel>(
      builder: (context, model, child) => RefreshIndicator(
        key: _refreshIndicatorKey,
        child: ListView.builder(
            itemBuilder: (context, index) =>
                _item(context, model.getSpecificTopics(contentType)[index]),
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: model.getSpecificTopics(contentType).length),
        onRefresh: () => model.refreshSpecificTopics(contentType),
      ),
    );
  }
}

///节点对应主题
class NodeTopic extends StatelessWidget {
  NodeTopic(this.title);

  final String title;

  //文本间分割符
  final Text _divider = Text("-");

//列表item
  _item(BuildContext context, Topic topic) {
    //作者头像
    Padding _avatar = Padding(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
      child: ClipRRect(
        child: FadeInImage.memoryNetwork(
            width: 48,
            height: 48,
            fit: BoxFit.cover,
            placeholder: kTransparentImage,
            image: topic.member.avatarLarge),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    //内容
    Expanded _content = Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 8),
          Text(
            topic.title,
            softWrap: true,
          ),
          SizedBox(height: 8),
          Row(
            children: <Widget>[
              ButtonTheme(
                minWidth: 0,
                height: 24,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: FlatButton(
                  child: Text(topic.member.username),
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MemberDetailPage(topic.member.username),
                      ),
                    );
                  },
                ),
              ),
              _divider,
              Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: Text(
                    topic.fromNowTerm(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );

    return GestureDetector(
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _avatar,
            _content,
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: Text(
                topic.replies.toString(),
                style: TextStyle(color: Colors.black54),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TopicContent(topic.id, topic.title, topic.content)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NodeTopicModel(title),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: Consumer<NodeTopicModel>(
          builder: (context, model, child) => RefreshIndicator(
            child: ListView.builder(
                itemBuilder: (context, index) =>
                    _item(context, model.getNodeTopics()[index]),
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: model.getNodeTopics().length),
            onRefresh: () => model.refreshTopicByNode(),
          ),
        ),
      ),
    );
  }
}
