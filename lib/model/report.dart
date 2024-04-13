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

}