import 'dart:convert';
import 'package:selenium_chat/model/message.dart';

import 'chat.dart';
import 'api.dart';
import 'dart:developer' as developer;

class ChatDAO {
  static Future<List<Chat>> all() async {
    final resp = await Api.get(route: "/chat", token: true);
    List data = jsonDecode(resp.data);
    developer.log('ChatDAO - all()');

    List<Chat> result = data.map<Chat>((item) => Chat.fromJson(item)).toList();
    return result;
  }

  static Future<Chat> get(int id) async {
    final resp = await Api.get(route: "/chat/$id", token: true);
    Map<String, dynamic> data = jsonDecode(resp.data);
    //developer.log('ChatDAO - get()');
    List data_messages = List<Map<String, dynamic>>.from(data['messages']);
    List<Message> messages = [];
    for(var message in data_messages){
      messages.add(Message.fromJson(message));
    }
    //data_messages.map<Message>((item) => Message.fromJson(item)); //IL BUG LA
    Chat result = Chat(
      id: data['id'],
      name: data['name'],
      createdAt: data['created_at'],
      messages: messages,
      lastMessage:data['last_message']['content'],
    );
    return result;
  }

  static Future<Chat?> create({required Map<String, String>? params}) async {
    final resp = await Api.post(route: "/chat", bodyParams: params, token: true);
    developer.log('ChatDAO - create() : ${resp.data}');
    Chat chat = Chat.fromJson(jsonDecode(resp.data));
    return chat;
  }
}
