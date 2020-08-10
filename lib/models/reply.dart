import 'package:flutter/widgets.dart';
import 'package:v2exreader/data/reply.dart';
import 'package:v2exreader/network/http_util.dart';

class ReplyModel with ChangeNotifier {
  final int id;

  ReplyModel(this.id) {
    refreshReplies();
  }

  List<Show> replies = [];

  List<Show> getReplies() => replies;

  refreshReplies() async {
    List<Show> refreshData = await HttpUtil.loadReplies(id);
    replies.clear();
    replies.addAll(refreshData);
    notifyListeners();
  }
}
