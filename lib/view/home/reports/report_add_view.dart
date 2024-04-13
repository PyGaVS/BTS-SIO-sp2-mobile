import 'package:flutter/material.dart';
import 'package:selenium_chat/config/app_settings.dart';
import 'package:selenium_chat/view_model/home_view_model.dart';
import 'package:selenium_chat/model/message.dart';
import 'package:selenium_chat/config/app_settings.dart';
import 'dart:developer' as developer;

class ReportAddView extends StatefulWidget {
  final HomeViewModel hvm;

  final Message message;

  const ReportAddView({super.key, required this.hvm, required this.message});

  State<ReportAddView> createState() => ReportAddViewState();
}

class ReportAddViewState extends State<ReportAddView> {

  String _purpose = 'spam';
  final TextEditingController _content = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    List<Widget> formColumn = [];

    sendReport({required String purpose, required String content}) async{
      await widget.hvm.addReport({
        'purpose': _purpose,
        'content': content,
        'message_id': widget.message.getId().toString()
      }).then((success) {
        if(success) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppSettings.BG_COLOR2,
            content: Text("Rapport envoyé"),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Erreur veuillez réessayer plus tard"),
          ));
        }
      }).whenComplete((){
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
    }

    Map<String, String> purposes = {
      'spam': 'spam',
      'insult': 'insulte',
      'sensitive data': 'donnée sensible',
      'threat': 'menace',
      'sexual assault': 'aggression sexuelle',
      'political opinion': 'opinion politique'
    };

    purposes.forEach((key, value) {
      formColumn.add(
        ListTile(
          title: Text(value, style: const TextStyle(color: Colors.white)),
          leading: Radio<String>(
            value: key,
            groupValue: _purpose,
            onChanged: (String? value) {
              setState(() {
                _purpose = value ?? 'spam';
              });
            },
          )
        )
      );
    });

    formColumn.addAll([
      Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: _content,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.summarize_sharp, color: Colors.deepPurpleAccent),
                  labelText: 'Détails',
                  border: OutlineInputBorder(),
                ),
                onChanged: (a){_scrollController.jumpTo(_scrollController.position.maxScrollExtent);},
                onFieldSubmitted: (fieldText){
                  developer.log('AAAAAAAAAAAA' + fieldText);
                  sendReport(purpose: _purpose, content: fieldText);
                },

              ),
            ),
            const SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: (){
                  sendReport(purpose: _purpose, content: _content.text);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                icon: const Icon(Icons.send_sharp)),
          ]
      )
    ]);

    return AlertDialog(
      backgroundColor: AppSettings.BG_COLOR2,
      scrollable: true,
      title: const Text('Signaler un message', style: TextStyle(color: Colors.white)),
      content: SingleChildScrollView(
            controller: _scrollController,
              child: Form(
                child: Column(
                  children: formColumn
                ),
              )
            )
    );
  }
}