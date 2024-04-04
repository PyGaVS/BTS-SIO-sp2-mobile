import 'package:flutter/material.dart';
import 'package:selenium_chat/model/chat.dart';
import 'package:selenium_chat/model/chat_dao.dart';
import 'dart:developer' as developer;

class HomeViewModel extends ChangeNotifier {

  late Future<List<Chat>> chats;

  HomeViewModel(){}

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

  Future<void> initShowChat() async{
    developer.log('initShowChat()');
  }

  Future<void> showChat() async{
    developer.log('showChat()');
    notifyListeners();
  }

  getChats(){
    return chats;
  }



}
