import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

// Views
import 'view/landing_view.dart';
import 'view/authenticate/login_view.dart';

class App{

  //Properties
  late MaterialApp _startUpView;

  //Constructor
  App(){
    //Create object
    this._startUpView = MaterialApp(title: "Selenium",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LandingView(),
        '/login': (context) => LoginView(),
      },
    );
  }

  //Getters and setters
  MaterialApp getStartUpView(){
    return this._startUpView;
  }
}
