import 'package:flutter/material.dart';
import 'package:selenium_chat/model/auth.dart';
import 'package:selenium_chat/model/chat.dart';
import 'package:selenium_chat/model/chat_dao.dart';
import 'dart:developer' as developer;

import 'package:selenium_chat/model/message_dao.dart';

class HomeViewModel extends ChangeNotifier {

  late Future<List<Chat>> chats;
  late Future<Chat> chat;
  static int currentChatId = 0;

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
    currentChatId = chat.id;
  }

  Future<void> showChat() async{
    developer.log('showChat()');
    this.chat = ChatDAO.get(currentChatId);
    notifyListeners();
  }

  getChats(){
    return chats;
  }

  Future<bool> addMessage(Map<String, String> params) async {
    params['user_id'] = Auth.id.toString();
    params['chat_id'] = HomeViewModel.currentChatId.toString();
    final message = await MessageDAO.create(params: params);

    if(message != null) {
      showChat();
      final refreshChat = await chat;
      refreshChat.messages.add(message);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }



}
