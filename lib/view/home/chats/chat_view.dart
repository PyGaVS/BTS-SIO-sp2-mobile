import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selenium_chat/app.dart';
import 'package:selenium_chat/view/component/nav_drawable_widget.dart';
import 'package:selenium_chat/config/app_settings.dart';
import 'dart:developer' as developer;
import 'package:selenium_chat/view_model/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:selenium_chat/model/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  ScrollController _scrollController = ScrollController();

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
              WidgetsBinding.instance.addPostFrameCallback((_) {
                //S'exécute après la construction de la liste
                _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
              });
              return ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data!.messages!.length,
                  itemBuilder: (context, index){
                    Color bgColor = index % 2 == 0 ? AppSettings.BG_COLOR2 : AppSettings.BG_COLOR;
                    Color userColor = snapshot.data!.messages![index].getUser().getUsername() == Auth.username ?
                      Colors.amber : Colors.white;
                    return ListTile(
                        tileColor: bgColor,
                        title: Text(
                          snapshot.data!.messages![index].getUser().getUsername(),
                          style: TextStyle(color: userColor)
                        ),
                        subtitle: Text(
                            snapshot.data!.messages![index].content,
                            style: const TextStyle(color: Colors.white)),
                        onLongPress: (){
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context){
                                return Container(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [AppSettings.BG_COLOR2, AppSettings.BG_COLOR],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter
                                      ),
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                  ),
                                  child: Wrap(
                                    children: <Widget>[
                                      ListTile(
                                        leading: const Icon(Icons.flag_sharp, color: Colors.red,),
                                        title: const Text('Signaler', style: TextStyle(color: Colors.red)),
                                        onTap: (){},
                                      ),
                                    ],
                                  )
                                );
                              }
                          );
                        },
                    );
                  }
              );
            }
          }
      )
      //bottomSheet: , ICIIII
    );
  }
}