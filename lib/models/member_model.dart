import 'package:flutter/foundation.dart';
import 'package:v2ex_reader/data/member.dart';
import 'package:v2ex_reader/data/topic.dart';
import 'package:v2ex_reader/network/http_util.dart';
import 'package:v2ex_reader/utils/log_util.dart';

class MemberModel with ChangeNotifier {
  MemberModel(this._memberName) {
    Logs.d(message: "MemberModel init");
//    refreshMember();
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

//  refreshMemberTopic() async {
//    List<Topic> result = await HttpUtil.loadTopicByMember(_memberName);
//    memberTopic.clear();
//    memberTopic.addAll(result);
//    notifyListeners();
//  }
}
