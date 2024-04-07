import 'dart:convert';
import 'dart:developer' as developer;
import 'user.dart';
import 'api.dart';

class UserDAO {
  static Future<User> user() async {
    final resp = await Api.get(route: "/user", token: true);
    Map<String, dynamic> data = jsonDecode(resp.data);
    developer.log('UserDAO - user()');

    User result = User.fromJson(data);
    return result;
  }
}