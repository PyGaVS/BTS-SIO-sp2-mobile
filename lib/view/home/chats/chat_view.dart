import 'package:flutter/material.dart';
import 'package:selenium_chat/view/component/nav_drawable_widget.dart';
import 'package:selenium_chat/config/app_settings.dart';
import 'dart:developer' as developer;
import 'package:selenium_chat/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    developer.log('ChatViewState - initState()');
    super.initState();
  }

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
      body: FutureBuilder<Chat>(
          future: widget.hvm.chat,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.messages!.length,
                  itemBuilder: (context, index){
                    return ListTile(
                        title: Text(
                            snapshot.data!.messages![index].content,
                            style: const TextStyle(color: Colors.white))
                    );
                  }
              );
            }
          }
      )
    );
  }
}