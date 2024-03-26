class Chat {
  int? id;
  String? name;

  Chat({this.id, this.name});

  getId(){
    return id;
  }

  getName(){
    return name;
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
        id: json['id'],
        name: json['name']
    );
  }
}
