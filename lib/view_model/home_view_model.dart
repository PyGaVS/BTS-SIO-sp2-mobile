import 'package:flutter/material.dart';
import 'package:selenium_chat/model/auth.dart';
import 'package:selenium_chat/model/chat.dart';
import 'package:selenium_chat/model/user.dart';
import 'package:selenium_chat/model/chat_dao.dart';
import 'dart:developer' as developer;
import 'dart:async';

import 'package:selenium_chat/model/message_dao.dart';
import 'package:selenium_chat/model/report_dao.dart';

class HomeViewModel extends ChangeNotifier {

  late Future<List<Chat>> chats;
  late Future<Chat> chat;

  static int currentChatId = 0;
  late Timer _timer;

  //HomeViewModel(){}

  Future<void> initBrowChats() async{
    developer.log('initBrowChat()');
    chats = ChatDAO.all();
  }

  Future<void> browChats() async{
    developer.log('browChat()');
    chats = ChatDAO.all();
    notifyListeners();
    //return ChatDAO.all();
  }

  Future<void> initBrowUsers() async{
    developer.log('initBrowUsers()');
    //chats = UserDAO.all();
  }

  Future<void> browUsers() async{
    developer.log('browUsers()');
    //chats = UserDAO.all();
    notifyListeners();
  }

  Future<void> initShowChat(Chat chat) async{
    developer.log('initShowChat()');
    this.chat = ChatDAO.get(chat.id);
    currentChatId = chat.id;
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      this.showChat();
    });
  }

  Future<void> showChat() async{
    //developer.log('showChat()');
    this.chat = ChatDAO.get(currentChatId);
    notifyListeners();
  }

  stopTimer(){
    _timer.cancel();
  }

  getChats(){
    return chats;
  }

  Future<bool> addMessage(Map<String, String> params) async {
    params['user_id'] = Auth.id.toString();
    params['chat_id'] = HomeViewModel.currentChatId.toString();
    final message = await MessageDAO.create(params: params);

    if(message != null) {
      await showChat();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addReport(Map<String, String> params) async {
    final report = await ReportDAO.create(params: params);

    if(report != null){
      return true;
    } else {
      return false;
    }
  }
}
