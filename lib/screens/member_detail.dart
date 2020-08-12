import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2ex_reader/data/member.dart';
import 'package:v2ex_reader/data/topic.dart';
import 'package:v2ex_reader/models/member_model.dart';
import 'package:v2ex_reader/screens/replies.dart';
import 'package:v2ex_reader/screens/topics.dart';
import 'package:v2ex_reader/transparent_image.dart';
import 'package:v2ex_reader/utils/log_util.dart';

///用户详情页面
class MemberDetailPage extends StatelessWidget {
  MemberDetailPage(this._memberName);

  final String _memberName;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<Widget> _buildColumn(BuildContext context, MemberModel model) {
    List<Widget> places = [];
    if (model.memberDetail != null) {
      places.add(_memberDetail(context, model.memberDetail));
    }
    Widget refreshIndicator = Expanded(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        child: ListView.builder(
            itemBuilder: (context, index) =>
                _memberTopicItem(context, model.memberTopic[index]),
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: model.memberTopic.length),
        onRefresh: () => model.refreshMember(),
      ),
    );
    places.add(refreshIndicator);
    return places;
  }

  _memberDetail(BuildContext context, MemberDetail memberDetail) {
    List<Widget> detailLiner = [];
    if (memberDetail.tagLine != null && memberDetail.tagLine.isNotEmpty) {
      List<Widget> tagLine = [
        SizedBox(height: 8),
        Text(memberDetail.tagLine,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ];
      detailLiner.addAll(tagLine);
    }
    List<Widget> created = [
      SizedBox(height: 8),
      Text(
        memberDetail.indexAndCreateTime(),
        style: TextStyle(fontSize: 14),
      ),
      SizedBox(height: 8),
    ];
    detailLiner.addAll(created);
    if (memberDetail.website != null && memberDetail.website.isNotEmpty) {
      List<Widget> website = [
        ButtonTheme(
          minWidth: 0,
          height: 24,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: FlatButton(
            child: Text(
              memberDetail.website,
              style: TextStyle(fontSize: 14, color: Colors.black38),
            ),
            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
            onPressed: () {},
          ),
        ),
        SizedBox(height: 8),
      ];
      detailLiner.addAll(website);
    }

    if (memberDetail.bio != null && memberDetail.bio.isNotEmpty) {
      List<Widget> bio = [
        Text(
          memberDetail.bio,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8)
      ];
      detailLiner.addAll(bio);
    }

    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(6, 8, 6, 8),
            child: ClipRRect(
              child: FadeInImage.memoryNetwork(
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  placeholder: kTransparentImage,
                  image: memberDetail.avatarLarge),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: detailLiner,
            ),
          )
        ],
      ),
    );
  }

  _memberTopicItem(BuildContext context, Topic topic) {
    //文本间分割符
    final Text _divider = Text("-");
    //内容
    Expanded _content = Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 8),
          Padding(
            child: Text(
              topic.title,
              softWrap: true,
            ),
            padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
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
                  padding: EdgeInsets.fromLTRB(8, 0, 4, 0),
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

    Logs.d(message: "MemberDetailPage build");

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _refreshIndicatorKey.currentState.show();
    });

    return ChangeNotifierProvider(
        create: (context) => MemberModel(_memberName),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              _memberName,
              style: TextStyle(fontSize: 18),
            ),
          ),
          body: Consumer<MemberModel>(
            builder: (context, model, child) => Column(
              children: _buildColumn(context, model),
            ),
          ),
        ));
  }
}
