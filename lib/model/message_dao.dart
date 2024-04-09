import 'dart:convert';
import 'message.dart';
import 'api.dart';
import 'dart:developer' as developer;

class MessageDAO {
  static Future<Message?> create({required Map<String, String>? params}) async {
    final resp = await Api.post(route: "/message", bodyParams: params, token: true);
    developer.log('MessageDAO - create() : ${resp.data}');
    Message message = Message.fromJson(jsonDecode(resp.data));
    return message;
  }
}