// 热门话题
/*{
"node": {
"avatar_large": "//cdn.v2ex.com/navatar/c20a/d4d7/12_large.png?m=1580443989",
"name": "qna",
"avatar_normal": "//cdn.v2ex.com/navatar/c20a/d4d7/12_normal.png?m=1580443989",
"title": "问与答",
"url": "https://www.v2ex.com/go/qna",
"topics": 147563,
"footer": "",
"header": "一个更好的世界需要你持续地提出好问题。",
"title_alternative": "Questions and Answers",
"avatar_mini": "//cdn.v2ex.com/navatar/c20a/d4d7/12_mini.png?m=1580443989",
"stars": 2790,
"aliases": [],
"root": false,
"id": 12,
"parent_node_name": "v2ex"
},
"member": {
"username": "varzy",
"website": "varzy.me",
"github": "varzy",
"psn": "",
"avatar_normal": "//cdn.v2ex.com/avatar/ba03/d214/200591_mini.png?m=1478691439",
"bio": "",
"url": "https://www.v2ex.com/u/varzy",
"tagline": "",
"twitter": "",
"created": 1478691373,
"avatar_large": "//cdn.v2ex.com/avatar/ba03/d214/200591_mini.png?m=1478691439",
"avatar_mini": "//cdn.v2ex.com/avatar/ba03/d214/200591_mini.png?m=1478691439",
"location": "",
"btc": "",
"id": 200591
},
"last_reply_by": "Lightio",
"last_touched": 1580623382,
"title": "我无家可归了，我该怎么办",
"url": "https://www.v2ex.com/t/641467",
"created": 1580556581,
"content": "由于公司需要远程办公，但家里没有电脑，于是提前来了公司。16 点到住处楼下，结果滨海市 zf 14 点发了通知，要求外来人员不能返乡。<br><br>我离住处只剩一个电梯的距离，却被拦下来不让进。公寓相关工作人员向 zf 提交申请后也不允许入住。附近的酒店也都没有开，而且即使是开了，吃饭也是个问题。<br><br>但是如果回家的话，也许没几天又要过来，光车票就要大几百。最重要的是，就算回去，也不一定回得去了。<br><br>我长这么大第一次遇到这么绝望的时刻，我现在到底该怎么办？",
"content_rendered": "<p>由于公司需要远程办公，但家里没有电脑，于是提前来了公司。16 点到住处楼下，结果滨海市 zf 14 点发了通知，要求外来人员不能返乡。<br/><br/>我离住处只剩一个电梯的距离，却被拦下来不让进。公寓相关工作人员向 zf 提交申请后也不允许入住。附近的酒店也都没有开，而且即使是开了，吃饭也是个问题。<br/><br/>但是如果回家的话，也许没几天又要过来，光车票就要大几百。最重要的是，就算回去，也不一定回得去了。<br/><br/>我长这么大第一次遇到这么绝望的时刻，我现在到底该怎么办？</p>\n",
"last_modified": 1580556581,
"replies": 99,
"id": 641467
}*/
class Topic {
  final Node node;
  final Member member;
  final String lastReplyBy;
  final int lastTouched;
  final String title;
  final String url;
  final int created;
  final String content;
  final String contentRendered;
  final int lastModified;
  final int replies;
  final int id;

  Topic(
      this.node,
      this.member,
      this.lastReplyBy,
      this.lastTouched,
      this.title,
      this.url,
      this.created,
      this.content,
      this.contentRendered,
      this.lastModified,
      this.replies,
      this.id);

  String fromNowTerm() {
    int now = DateTime.now().millisecondsSinceEpoch ~/1000;
    print("now:$now");
    print("lastModified:$lastModified");
    int seconds = now - lastModified;
    int day = seconds ~/ (3600 * 24);
    int hour = seconds % (3600 * 24) ~/ 3600;
    int minute = seconds % (3600 * 24) % 3600 ~/ 60;
    String a = day != 0 ? "$day天" : "";
    String b = hour != 0 ? "$hour小时" : "";
    String c = minute != 0 ? "$minute分钟" : "";
    return a + b + c + "前";
  }

  Topic.fromJson(Map<String, dynamic> json)
      : node = Node.fromJson(json['node']),
        member = Member.fromJson(json['member']),
        lastReplyBy = json['last_reply_by'],
        lastTouched = json['last_touched'],
        title = json['title'],
        url = json['url'],
        created = json['created'],
        content = json['content'],
        contentRendered = json['content_rendered'],
        lastModified = json['last_modified'],
        replies = json['replies'],
        id = json['id'];
}

class Node {
  final String avatarLarge,
      name,
      avatarNormal,
      title,
      url,
      footer,
      header,
      titleAlternative,
      avatarMini,
      parentNodeName;
  final int topics, stars, id;
  final bool root;

  Node(
      this.avatarLarge,
      this.name,
      this.avatarNormal,
      this.title,
      this.url,
      this.footer,
      this.header,
      this.titleAlternative,
      this.avatarMini,
      this.parentNodeName,
      this.topics,
      this.stars,
      this.id,
      this.root);

  Node.fromJson(Map<String, dynamic> json)
      : avatarLarge = json['avatar_large'],
        name = json['name'],
        avatarNormal = json['avatar_normal'],
        title = json['title'],
        url = json['url'],
        footer = json['footer'],
        header = json['header'],
        titleAlternative = json['avatar_large'],
        avatarMini = json['avatar_large'],
        parentNodeName = json['parent_node_name'],
        topics = json['topics'],
        stars = json['stars'],
        id = json['id'],
        root = json['root'];
}

class Member {
  final String username,
      website,
      github,
      psn,
      url,
      avatarNormal,
      avatarLarge,
      avatarMini;
  final int id;

  Member(this.username, this.website, this.github, this.psn, this.url,
      this.avatarMini, this.avatarNormal, this.avatarLarge, this.id);

  Member.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        website = json['website'],
        github = json['github'],
        psn = json['psn'],
        url = json['url'],
        avatarMini = json['avatar_mini'],
        avatarNormal = json['avatar_normal'],
        avatarLarge = json['avatar_large'],
        id = json['id'];
}
