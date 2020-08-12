import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2ex_reader/data/reply.dart';
import 'package:v2ex_reader/models/reply_model.dart';
import 'package:v2ex_reader/screens/member_detail.dart';
import 'package:v2ex_reader/utils/log_util.dart';

import '../transparent_image.dart';

///话题及回复
class TopicContent extends StatelessWidget {
  TopicContent(this._id, this._title, this._content);

  final int _id;
  final String _title, _content;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReplyModel(_id, _content),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Text(
            _title,
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: ReplyList(),
      ),
    );
  }
}

class ReplyList extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  //文本间分割符
  final Text _divider = Text("-");

  //列表item
  _item(BuildContext context, Show topic) {
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
            topic.content,
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

    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _avatar,
          _content,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Logs.d(message: "ReplyList build");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _refreshIndicatorKey.currentState.show();
    });

    return Consumer<ReplyModel>(
      builder: (context, model, child) => RefreshIndicator(
        key: _refreshIndicatorKey,
        child: ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Text(
                      model.content.isEmpty ? "rt如题rt" : model.content,
                      softWrap: true,
                    ),
                  ),
                );
              } else {
                return _item(context, model.getReplies()[index - 1]);
              }
            },
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: model.getReplies().length + 1),
        onRefresh: () => model.refreshReplies(),
      ),
    );
  }
}
