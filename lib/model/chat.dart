import 'message.dart';
import 'dart:developer' as developer;

class Chat {
  int id;
  String name;
  String createdAt;
  //List<Message> messages;
  Message lastMessage;

  Chat({
    required this.id,
    required this.name,
    required this.createdAt,
    //required this.messages,
    required this.lastMessage,
  });

  getId(){
    return id;
  }

  getName(){
    return name;
  }


  getLastMessage(){
    return lastMessage.content;
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
        id: json['id'],
        name: json['name'],
        createdAt: json['created_at'],
        //messages: json['messages'],
        lastMessage: Message.fromJson(json['last_message']),
    );
  }
}
