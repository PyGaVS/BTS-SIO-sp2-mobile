import 'package:flutter/material.dart';
import 'package:selenium_chat/model/chat.dart';
import 'package:selenium_chat/model/chat_dao.dart';
import 'dart:developer' as developer;

class HomeViewModel extends ChangeNotifier {

  late Future<List<Chat>> chats;
  late Future<Chat> chat;

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

  Future<void> initShowChat(Chat chat) async{
    developer.log('initShowChat()');
    this.chat = ChatDAO.get(chat.id);
  }

  Future<void> showChat() async{
    developer.log('showChat()');
    notifyListeners();
  }

  getChats(){
    return chats;
  }



}
