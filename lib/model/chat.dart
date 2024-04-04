import 'message.dart';
import 'dart:developer' as developer;

class Chat {
  int id;
  String name;
  String createdAt;
  List<Message>? messages;
  String lastMessage;

  Chat({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.lastMessage,
    this.messages,
  });

  getId(){
    return id;
  }

  getName(){
    return name;
  }


  getLastMessage(){
    return lastMessage;
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
        id: json['id'],
        name: json['name'],
        createdAt: json['created_at'],
        //messages: json['messages'],
        lastMessage: json['last_message']['content'],
    );
  }
}
