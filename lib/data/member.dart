import 'package:intl/intl.dart';

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

//  Member(this.username, this.website, this.github, this.psn, this.url,
//      this.avatarMini, this.avatarNormal, this.avatarLarge, this.id);

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

//{
//	"username": "Livid",
//	"website": "https://livid.v2ex.com/",
//	"github": "",
//	"psn": "",
//	"avatar_normal": "https://cdn.v2ex.com/avatar/c4ca/4238/1_mini.png?m=1583753654",
//	"bio": "Remember the bigger green",
//	"url": "https://www.v2ex.com/u/Livid",
//	"tagline": "Gravitated and spellbound",
//	"twitter": "",
//	"created": 1272203146,
//	"status": "found",
//	"avatar_large": "https://cdn.v2ex.com/avatar/c4ca/4238/1_mini.png?m=1583753654",
//	"avatar_mini": "https://cdn.v2ex.com/avatar/c4ca/4238/1_mini.png?m=1583753654",
//	"location": "",
//	"btc": "",
//	"id": 1
//}
class MemberDetail {
  final int id, create;

  final String userName,
      website,
      github,
      psn,
      url,
      avatarNormal,
      bio,
      tagLine,
      twitter,
      status,
      location,
      btc,
      avatarLarge,
      avatarMini;

  String indexAndCreateTime() {
    final format = DateFormat("yyyy-MM-dd HH:mm:ss");
    final stringBuffer = StringBuffer("V2EX第 $id 号会员，加入于");
    stringBuffer.write(
        format.format(DateTime.fromMillisecondsSinceEpoch(create * 1000)));
    return stringBuffer.toString();
  }

  MemberDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        create = json["created"],
        userName = json['username'],
        website = json['website'],
        github = json['github'],
        psn = json['psn'],
        url = json['url'],
        avatarMini = json['avatar_mini'],
        avatarNormal = json['avatar_normal'],
        avatarLarge = json['avatar_large'],
        bio = json["bio"],
        tagLine = json["tagline"],
        twitter = json["twitter"],
        status = json["status"],
        location = json["location"],
        btc = json["btc"];
}
