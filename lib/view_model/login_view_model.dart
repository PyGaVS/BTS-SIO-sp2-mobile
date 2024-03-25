import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:selenium_chat/model/auth.dart';
//Manage the data and command of the LoginViews

class LoginViewModel extends ChangeNotifier {
  Future<bool> signInButtonOnClickCommand(username, password) async {
    developer.log('LoginViewModel - signInButtonOnClickCommand()');
    return await Auth.attempt(credentials: {'username': username, 'password': password});
  }
}

