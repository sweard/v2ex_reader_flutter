import 'package:flutter/foundation.dart';
import 'package:v2exreader/data/member.dart';
import 'package:v2exreader/data/topic.dart';
import 'package:v2exreader/network/http_util.dart';

class MemberModel with ChangeNotifier {
  MemberModel(this._memberName) {
    refreshMember();
  }

  final String _memberName;

  MemberDetail memberDetail;

  List<Topic> memberTopic = [];

  refreshMember() async {
    memberDetail = await HttpUtil.fetchMemberDetail(_memberName);
    List<Topic> result = await HttpUtil.loadTopicByMember(_memberName);
    memberTopic.clear();
    memberTopic.addAll(result);
    notifyListeners();
  }

  refreshMemberTopic() async {
    List<Topic> result = await HttpUtil.loadTopicByMember(_memberName);
    memberTopic.clear();
    memberTopic.addAll(result);
    notifyListeners();
  }
}
