import 'package:flutter/material.dart';
import 'package:selenium_chat/model/auth.dart';
import 'package:selenium_chat/model/chat.dart';
import 'package:selenium_chat/model/user.dart';
import 'package:selenium_chat/model/user_dao.dart';
import 'package:selenium_chat/model/chat_dao.dart';
import 'dart:developer' as developer;

class AddChatViewModel extends ChangeNotifier {

  late Future<List<User>> users;

  Future<void> initBrowUsers(String? search) async{
    developer.log('initBrowUsers()');
    users = UserDAO.all(search);
  }

  Future<void> browUsers(String? search) async{
    developer.log('browUsers()');
    users = UserDAO.all(search);
    notifyListeners();
  }

  Future<bool> addChat(Map<String, String> params) async {
    final chat = await ChatDAO.create(params: params);

    if(chat != null) {
      return true;
    } else {
      return false;
    }
  }
}