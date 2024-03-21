import 'package:flutter/material.dart';

// Views
import 'view/landing_view.dart';

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
      },
    );
  }

  //Getters and setters
  MaterialApp getStartUpView(){
    return this._startUpView;
  }
}
