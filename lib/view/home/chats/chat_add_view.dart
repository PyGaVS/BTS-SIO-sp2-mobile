import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selenium_chat/config/app_settings.dart';
import 'package:selenium_chat/view_model/addChat_view_model.dart';

import '../../../model/user.dart';

class ChatAddView extends StatefulWidget {
  //Properties
  final AddChatViewModel acvm;

  final List<int> users;
  //Constructor
  const ChatAddView({Key? key, required this.acvm, required this.users}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChatAddViewState();
  }
}

class ChatAddViewState extends State<ChatAddView> {
  TextEditingController _tecName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppSettings.BG_COLOR,
      child: Column(
          children: <Widget>[
            TextField(
                autofocus: true,
                controller: _tecName,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.chat_sharp, color: Colors.white),
                  labelText: 'Nom du groupe',
                  border: OutlineInputBorder(),
                )
            ),
            ElevatedButton(
                onPressed: (){
                  widget.acvm.addChat({
                    "name": _tecName.text,
                    "users": widget.users.join(';')
                  });
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                child: Text('Lancer la discussion'))
          ]),
    );
  }
}