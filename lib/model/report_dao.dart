import 'dart:convert';
import 'report.dart';
import 'api.dart';
import 'dart:developer' as developer;

class ReportDAO {
  static Future<Report?> create({required Map<String, String>? params}) async {
    final resp = await Api.post(route: "/report", bodyParams: params, token: true);
    developer.log('ReportDAO - create() : ${resp.data}');
    Report report = Report.fromJson(jsonDecode(resp.data));
    return report;
  }
}