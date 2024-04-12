import 'package:flutter/material.dart';
import 'package:selenium_chat/config/app_settings.dart';
import 'dart:developer' as developer;
import 'package:selenium_chat/view_model/home_view_model.dart';
import 'package:selenium_chat/model/auth.dart';
import 'package:selenium_chat/view/home/messages/message_browse_view.dart';

import '../../../model/chat.dart';
import '../../../model/message.dart';

class ChatView extends StatefulWidget {
  //Properties

  final HomeViewModel hvm;

  final Chat chat;

  //Constructor
  const ChatView({Key? key, required this.hvm, required this.chat});

  @override
  State<StatefulWidget> createState() {
    return ChatViewState();
  }
}

class ChatViewState extends State<ChatView> {
  //Properties
  final TextEditingController _tecContent = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    widget.hvm.initShowChat(widget.chat);
    developer.log('ChatViewState - build()');

    return Scaffold(
      backgroundColor: AppSettings.BG_COLOR,
      appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          foregroundColor: Colors.white,
          title: Text(widget.chat.name)
      ),
      body: Column(
          children: <Widget>[
            MessageBrowseView(hvm: widget.hvm),
            Container(
             padding: const EdgeInsets.all(8.0),
             color: AppSettings.BG_COLOR,
             child: Row(
               children: <Widget>[
                 Expanded(
                   child: TextField(
                     controller: _tecContent,
                     focusNode: _focusNode,
                     style: const TextStyle(color: Colors.white),
                     decoration: const InputDecoration(border: OutlineInputBorder()),
                   ),
                 ),
                 const SizedBox(
                   width: 6,
                 ),
                 IconButton(
                     onPressed: (){
                       widget.hvm.addMessage({
                         'content': _tecContent.text
                       });
                       _tecContent.clear();
                       _focusNode.unfocus();
                       },
                     style: ButtonStyle(
                       backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                       foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                     ),
                     icon: const Icon(Icons.send_sharp)),
               ]
             )
           )
          ]
      )
    );
  }
}