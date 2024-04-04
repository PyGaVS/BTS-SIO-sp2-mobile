import 'dart:convert';
import 'package:selenium_chat/model/message.dart';

import 'chat.dart';
import 'api.dart';
import 'dart:developer' as developer;

class ChatDAO {
  static Future<List<Chat>> all() async {
    final resp = await Api.get(route: "/chat", token: true);
    List data = jsonDecode(resp.data);
    developer.log('CategoryDAO - all()');

    List<Chat> result = data.map<Chat>((item) => Chat.fromJson(item)).toList();
    return result;
  }

  static Future<Chat> get(int id) async {
    final resp = await Api.get(route: "/chat/$id", token: true);
    Map<String, dynamic> data = jsonDecode(resp.data);
    developer.log('CategoryDAO - get()');
    Chat result = Chat(
      id: data['id'],
      name: data['name'],
      createdAt: data['created_at'],
      messages: data['messages'].map<Message>((item) => Message.fromJson(item)).toList(),
      lastMessage:data['last_message']['content'],
    );
    return result;
  }
}
