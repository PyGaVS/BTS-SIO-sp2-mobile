import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:selenium_chat/view_model/home_view_model.dart';
import 'package:selenium_chat/model/chat.dart';

import 'package:provider/provider.dart';

class ChatBrowseView extends StatefulWidget {
  //Properties
  //Constructor
  const ChatBrowseView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChatBrowseViewState();
  }
}

class ChatBrowseViewState extends State<StatefulWidget> {

  @override
  void initState() {
    developer.log('ChatBrowseView - initState()');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    developer.log('ChatBrowseViewState - build()');
    return Consumer<HomeViewModel>(builder : (_,hvm,__) => Expanded(
      child: RefreshIndicator(
        onRefresh: () => hvm.browChats(),
        child: FutureBuilder<List<Chat>>(
          future: hvm.chats,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.mark_chat_unread_rounded, color: Colors.white),
                    title: Text(snapshot.data![index].getName(),
                    style: const TextStyle(color: Colors.white)),
                  );
                },
              );
            }
          }
        )
      )
    ));
  }
}