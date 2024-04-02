import 'dart:convert';
import 'chat.dart';
import 'api.dart';
import 'dart:developer' as developer;

class ChatDAO {
  static Future<List<Chat>> all() async {
    final resp = await Api.get(route: "/chat", token: true);
    List data = jsonDecode(resp.data);
    developer.log('CategoryDAO - get() : ${resp.data}');

    List<Chat> result = data.map<Chat>((item) => Chat.fromJson(item)).toList();
    return result;
  }
}
