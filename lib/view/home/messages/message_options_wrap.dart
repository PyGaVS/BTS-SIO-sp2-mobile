import 'package:flutter/material.dart';
import 'package:selenium_chat/config/app_settings.dart';
import 'package:selenium_chat/model/message.dart';
import 'package:selenium_chat/model/auth.dart';

class MessageOptionsWrap extends StatelessWidget {

  final Message message;

  const MessageOptionsWrap({super.key, required this.message});

  @override
  Widget build(BuildContext context) {

    List<Widget> wrapItems = <Widget>[];
    if(message.getUser().username == Auth.username) {
      wrapItems = <Widget>[
        ListTile(
          leading: const Icon(Icons.edit_sharp, color: Colors.white),
          title: const Text('Modifier', style: TextStyle(color: Colors.white)),
          onTap: () {},
        ),
      ];
    } else {
      wrapItems = <Widget>[
        ListTile(
          leading: const Icon(Icons.flag_sharp, color: Colors.red,),
          title: const Text('Signaler', style: TextStyle(color: Colors.red)),
          onTap: () {},
        ),
      ];
    }
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
          children: wrapItems
        )
    );
  }
}