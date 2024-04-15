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

  static Future<List<User>> all(String? search) async {
    search = search ?? '';
    final resp = await Api.get(route: "/users/$search", token: true);
    List data = jsonDecode(resp.data);
    developer.log("UserDAO - all($search)");

    List<User> result = data.map<User>((item) => User.fromJson(item)).toList();
    return result;
  }
}