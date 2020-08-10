import 'package:flutter/widgets.dart';
import 'package:v2exreader/data/replies.dart';
import 'package:v2exreader/network/http_util.dart';

class TopicViewModel with ChangeNotifier {
  final int id;

  TopicViewModel(this.id) {
    refreshReplies();
  }

  List<Show> replies = [];

  refreshReplies() async {
    List<Show> refreshData = await HttpUtil.loadReplies(id);
    replies.clear();
    replies.addAll(refreshData);
    notifyListeners();
  }
}
