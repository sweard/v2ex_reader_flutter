class Show {
  final String content, contentRendered;
  final Member member;
  final int id,  created, lastModified;

  String fromNowTerm() {
    int now = DateTime.now().millisecondsSinceEpoch ~/1000;
    int seconds = now - lastModified;
    int day = seconds ~/ (3600 * 24);
    int hour = seconds % (3600 * 24) ~/ 3600;
    int minute = seconds % (3600 * 24) % 3600 ~/ 60;
    String a = day != 0 ? "$day天" : "";
    String b = hour != 0 ? "$hour小时" : "";
    String c = minute != 0 ? "$minute分钟" : "几秒";
    return a + b + c + "前";
  }

  Show.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        content = json["content"],
        contentRendered = json["content_rendered"],
        member = Member.fromJson(json["member"]),
        created = json["created"],
        lastModified = json["last_modified"];
}

class Member {
  final int id;
  final String username, tagLine, avatarMini, avatarNormal, avatarLarge;

  Member.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        username = json["username"],
        tagLine = json["tagline"],
        avatarMini = json["avatar_mini"],
        avatarNormal = json["avatar_normal"],
        avatarLarge = json["avatar_large"];
}
