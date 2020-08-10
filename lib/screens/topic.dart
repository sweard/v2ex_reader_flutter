import 'package:flutter/material.dart';
import 'package:v2exreader/data/replies.dart';

import '../transparent_image.dart';

class Topic extends StatelessWidget{

  //文本间分割符
  final Text _divider = Text("-");

  //列表item
  _item(Show topic) {
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
          Row(
            children: <Widget>[
              ButtonTheme(
                minWidth: 0,
                height: 24,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: FlatButton(
                  child: Text(topic.member.username),
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                  onPressed: () {},
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
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Text(
              topic.thanks.toString(),
              style: TextStyle(color: Colors.black54),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<MainViewModel>(
      builder: (context, model, child) => RefreshIndicator(
        child: ListView.builder(
            itemBuilder: (context, index) =>
                _item(model.getSpecificTopics(contentType)[index]),
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: model.getSpecificTopics(contentType).length),
        onRefresh: () => model.refreshSpecificTopics(contentType),
      ),
    );
  }

}