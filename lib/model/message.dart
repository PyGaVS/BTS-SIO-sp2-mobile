import 'dart:developer' as developer;
import 'user.dart';

class Message {
  int id;
  String content;
  String createdAt;
  User user;

  Message({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.user});

  User getUser(){
    return user;
  }

  factory Message.fromJson(Map<String, dynamic> json) {

    Map<String, dynamic> user_data = json['user'];

    return Message(
        id: json['id'],
        content: json['content'],
        createdAt: json['created_at'],
        user: User.fromJson(user_data)
    );
  }
}