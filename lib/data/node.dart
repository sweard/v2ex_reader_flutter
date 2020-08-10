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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'avatarLarge': avatarLarge,
      'name': name,
      'avatarNormal': avatarNormal,
      'title': title,
      'url': url,
      'footer': footer,
      'header': header,
      'titleAlternative': titleAlternative,
      'avatarMini': avatarMini,
      'parentNodeName': parentNodeName,
      'topics': topics,
      'stars': stars,
      'root': root ? 1 : 0
    };
  }

  Node.fromMap(Map<String, dynamic> map)
      : avatarLarge = map['avatar_large'],
        name = map['name'],
        avatarNormal = map['avatar_normal'],
        title = map['title'],
        url = map['url'],
        footer = map['footer'],
        header = map['header'],
        titleAlternative = map['avatar_large'],
        avatarMini = map['avatar_large'],
        parentNodeName = map['parent_node_name'],
        topics = map['topics'],
        stars = map['stars'],
        id = map['id'],
        root = map['root'] == 1 ? true : false;
}
