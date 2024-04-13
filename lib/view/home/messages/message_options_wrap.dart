import 'package:flutter/material.dart';
import 'package:selenium_chat/config/app_settings.dart';
import 'package:selenium_chat/model/message.dart';
import 'package:selenium_chat/model/auth.dart';
import 'package:selenium_chat/view_model/home_view_model.dart';
import 'package:selenium_chat/view/home/reports/report_add_view.dart';

class MessageOptionsWrap extends StatefulWidget {
  final Message message;

  final HomeViewModel hvm;

  const MessageOptionsWrap({super.key, required this.message, required this.hvm});

  @override
  State<MessageOptionsWrap> createState() {
    return MessageOptionsWrapState();
  }
}

class MessageOptionsWrapState extends State<MessageOptionsWrap> {

  @override
  Widget build(BuildContext context) {

    List<Widget> wrapItems = <Widget>[];
    if(widget.message.getUser().username == Auth.username) {
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
          onTap: () {
            showDialog(context: context,
                builder: (context) => ReportAddView(hvm: widget.hvm, message: widget.message)
            );
          },
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