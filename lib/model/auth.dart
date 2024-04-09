
import 'api_response.dart';
import 'package:selenium_chat/model/api.dart';
import 'dart:developer' as developer;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {

  static String username = '';
  static int id = 0;

  static Future<bool> attempt({required Map<String, String> credentials}) async {
    developer.log('Auth - attempt() : \n Credentials : ${credentials.toString()}');
    final resp = await Api.post(route: "/login", bodyParams: credentials);
    if (resp.status == Status.COMPLETED) {
      Map<String, dynamic> response = jsonDecode(resp.data);

      if (response.containsKey('success')) {
        developer.log("Auth - attempt() :\n\t Token : ${response['success']['token']}");
        //Store the token for the api
        Api.token = response['success']['token'];

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', Api.token);

        return true;
      }
    }
    developer.log('Auth - attempt(): invalid credentials or API errors');
    return false;
  }

  static Future<bool> isUserConnected() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      developer.log('Auth - isUserConnected(): true');
      Api.token = prefs.getString('token') ?? 'no token';
      return true;
    } else {
      developer.log('Auth - isUserConnected(): true');
      return false;
    }
  }

  static Future<void> disconnectUser() async{
    developer.log('disconnectUser()');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }


}