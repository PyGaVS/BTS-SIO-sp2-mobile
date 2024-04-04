class Message {
  int id;
  String content;
  DateTime createdAt;

  Message({required this.id, required this.content, required this.createdAt});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        content: json['content'],
        createdAt: json['created_at']
    );
  }
}