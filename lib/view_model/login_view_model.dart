import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:selenium_chat/model/auth.dart';
import 'package:selenium_chat/model/user_dao.dart';
import 'package:selenium_chat/model/user.dart';
import 'package:selenium_chat/model/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
//Manage the data and command of the LoginViews

class LoginViewModel extends ChangeNotifier {
  Future<bool> signInButtonOnClickCommand(username, password) async {
    developer.log('LoginViewModel - signInButtonOnClickCommand()');
    return await Auth.attempt(credentials: {'username': username, 'password': password});
  }

  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = await UserDAO.user();
    Auth.username = user.username;
    prefs.setString('username', user.username);
  }
}

