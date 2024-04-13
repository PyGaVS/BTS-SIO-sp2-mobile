import 'package:flutter/material.dart';
import 'package:selenium_chat/config/app_settings.dart';
import 'dart:developer' as developer;
import 'package:selenium_chat/view_model/home_view_model.dart';
import 'package:selenium_chat/model/auth.dart';
import 'package:selenium_chat/model/chat.dart';
import 'message_options_wrap.dart';

class MessageBrowseView extends StatefulWidget {

  final HomeViewModel hvm;

  const MessageBrowseView({Key? key, required this.hvm}) : super(key: key);

  @override
  State<MessageBrowseView> createState() {
    return MessageBrowseViewState();
  }
}

class MessageBrowseViewState extends State<MessageBrowseView> {

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    developer.log('MessageBrowseViewState - build()');

    return Expanded(child: RefreshIndicator(
        onRefresh: () => widget.hvm.showChat(),
        child : ListenableBuilder(
            listenable: widget.hvm,
            builder: (BuildContext context, Widget? child){
              return FutureBuilder<Chat>(
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
                        itemCount: snapshot.data!.messages.length,
                        itemBuilder: (context, index){
                          Color bgColor = index % 2 == 0 ? AppSettings.BG_COLOR2 : AppSettings.BG_COLOR;
                          String username = snapshot.data!.messages[index].getUser().getUsername();
                          Color userColor = username == Auth.username ? Colors.amber : Colors.white;
                          return ListTile(
                            tileColor: bgColor,
                            title: Text(
                                snapshot.data!.messages[index].getUser().getUsername(),
                                style: TextStyle(color: userColor)
                            ),
                            subtitle: Text(
                                snapshot.data!.messages[index].content,
                                style: const TextStyle(color: Colors.white)),
                            onLongPress: (){
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context){
                                    return MessageOptionsWrap(message: snapshot.data!.messages[index], hvm: widget.hvm);
                                  }
                              );
                            },
                          );
                        },
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                      );}
                  }
              );
            })
    ));
  }
}