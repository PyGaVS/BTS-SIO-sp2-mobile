import 'package:flutter/material.dart';

class AppSettings {

  //Splashscreen settings
  static const int SPLASHSCREEN_DURATION = 1; //seconds

  //Application settings
  static const String APP_VERSION = 'v0';
  //static final APP_LOGO = Image.asset("lib/asset/images/alizon_logo_color.png");
  static const bool APP_DEBUG = true;


  //For the API REST consuming
  static const String API_URI = '192.168.1.133';
  static const int API_PORT = 8000;
  static const String API_PATH = 'api';
  static const String API_VERSION = 'v1';
  static const Color BG_COLOR = Color.fromRGBO(38, 38, 38, 1);
}
