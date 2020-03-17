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