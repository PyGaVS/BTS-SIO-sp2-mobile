import 'dart:developer' as developer;
import 'package:flutter/cupertino.dart';

import 'message.dart';

class Report {
  int id;
  String purpose;
  String content;
  int importanceRate;
  Message message;

  Report({
    required this.id,
    required this.purpose,
    required this.content,
    required this.importanceRate,
    required this.message
  });

  factory Report.fromJson(Map<String, dynamic> json) {

    Map<String, dynamic> message = json['message'];

    return Report(
        id: json['id'],
        content: json['content'],
        purpose: json['purpose'],
        importanceRate: json['importance_rate'],
        message: Message.fromJson(json['message'])
    );
  }

}