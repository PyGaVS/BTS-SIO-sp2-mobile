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
    developer.log('ChatDAO - get()');
    //developer.log(data['messages'].toString());
    List data_messages = List<Map<String, dynamic>>.from(data['messages']);
    //developer.log(messages.toString());
    for(var message in data_messages){
      message = Message.fromJson(message);
      developer.log(message.toString());
    }
    data_messages.map<Message>((item) => Message.fromJson(item)); //IL S'ARRÊTE LA
    Chat result = Chat(
      id: data['id'],
      name: data['name'],
      createdAt: data['created_at'],
      messages: [],
      lastMessage:data['last_message']['content'],
    );
    developer.log("ChatDAO - get() : $result");
    return result;
  }
}
