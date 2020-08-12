import 'package:flutter/widgets.dart';
import 'package:v2exreader/data/reply.dart';
import 'package:v2exreader/network/http_util.dart';
import 'package:v2exreader/utils/log_util.dart';

///主题下的回复
class ReplyModel with ChangeNotifier {
  final int id;
  final String content;

  ReplyModel(this.id, this.content) {
//    refreshReplies();
    Logs.d(message: "ReplyModel init");
  }

  List<Show> replies = [];

  List<Show> getReplies() {
    return replies;
  }

  refreshReplies() async {
    List<Show> refreshData = await HttpUtil.loadReplies(id);
    replies.clear();
    replies.addAll(refreshData);
    notifyListeners();
  }
}
