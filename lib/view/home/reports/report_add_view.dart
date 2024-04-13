import 'package:flutter/material.dart';
import 'package:selenium_chat/config/app_settings.dart';
import 'package:selenium_chat/view_model/home_view_model.dart';
import 'package:selenium_chat/model/message.dart';
import 'dart:developer' as developer;

class ReportAddView extends StatefulWidget {
  final HomeViewModel hvm;

  final Message message;

  const ReportAddView({super.key, required this.hvm, required this.message});

  State<ReportAddView> createState() => ReportAddViewState();
}

class ReportAddViewState extends State<ReportAddView> {

  String _purpose = 'spam';

  @override
  Widget build(BuildContext context) {

    List<Widget> purposeColumn1 = [];
    List<Widget> purposeColumn2 = [];

    Map<String, String> purposes1 = {
      'spam': 'spam',
      'insult': 'insulte',
      'sensitive data': 'donnée sensible',
    };

    Map<String, String> purposes2 = {
      'threat': 'menace',
      'sexual assault': 'aggression sexuelle',
      'political opinion': 'opinion politique'
    };

    purposes1.forEach((key, value) {
      purposeColumn1.add(
        ListTile(
          title: Text(value),
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

    purposes2.forEach((key, value) {
      purposeColumn2.add(
          ListTile(
              title: Text(value),
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

    developer.log(purposeColumn1.toString());

    return AlertDialog(
      backgroundColor: AppSettings.BG_COLOR2,
      title: const Text('Signaler un message', style: TextStyle(color: Colors.white)),
      content: Container(
          padding: EdgeInsets.all(0),
          child: Form(
            child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        children: purposeColumn1,
                      ),
                      Column(
                        children: purposeColumn2,
                      )
                    ],
                  )
                ]
            ),
          )
      ),
    );
  }
}