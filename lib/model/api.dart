import 'api_response.dart';
import 'dart:developer' as developer;
import 'package:selenium_chat/config/app_settings.dart';
import 'package:http/http.dart' as http;

class Api {
  //Properties
  static String token = ''; //Keep the token

  //Methods
  static Future<ApiResponse> post({required String? route, Map<String, String>? bodyParams, bool token=false}) async {
    Status status = Status.BUSY;
    developer.log('Api - post()');
    if (route != null) {
      developer.log(route);
      final uri = Uri(scheme: 'http',
          host: AppSettings.API_URI,
          port: AppSettings.API_PORT,
          path: '${AppSettings.API_PATH}/${AppSettings.API_VERSION}$route');
      developer.log('Api - post(): \n\t Uri: $uri');
      Map<String, String> headers = {
        //"Accept": "*/*",
        //"Content-Type": "multipart/form-data",
      };
      if (token) {
        developer.log("TOKEN : ${Api.token}");
        headers = {
          //"Accept": "*/*",
          //"Content-Type": "multipart/form-data",
          //"Authorization": "Bearer ${Api.token}"
        };
        headers.addAll({"Authorization": "Bearer ${Api.token}"});
      }

      final resp = await http.post(uri, body: bodyParams, headers: headers);

      switch (resp.statusCode) {
        case 200:
          status = Status.COMPLETED;
          developer.log('Api - post() : \n\tAPI is responding : ${resp.statusCode} - ${resp.body}');
          break;
        case 201:
          status = Status.COMPLETED;
          developer.log('Api - post() : \n\tAPI is responding : ${resp.statusCode} - ${resp.body}');
          break;

        default:
          status = Status.ERROR;
          developer.log('Api - post(): \n\tAPI respond with an error ${resp.statusCode}');

      }
      return ApiResponse(status, resp.body, resp.statusCode.toString());

    }
    developer.log('Api - post(): \n\tNo route specified !');
    return ApiResponse(Status.ERROR, null, 'No route specified');
  }
}