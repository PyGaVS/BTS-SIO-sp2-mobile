import 'package:flutter/material.dart';
import 'package:selenium_chat/model/chat.dart';

class HomeViewModel extends ChangeNotifier {

  late Future<List<Chat>> categories;

  HomeViewModel(){
  }

}
