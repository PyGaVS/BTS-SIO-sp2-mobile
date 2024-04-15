import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

// Views
import 'view/landing_view.dart';
import 'view/authenticate/login_view.dart';
import 'view/home/home_view.dart';
import 'view/addChat/users/user_choose_view.dart';

//ViewModels
import 'view_model/login_view_model.dart';
import 'view_model/home_view_model.dart';
import 'view_model/addChat_view_model.dart';

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
        '/login': (context) => ChangeNotifierProvider(create: (context) => LoginViewModel(), child: const LoginView()),
        '/home': (context) => ChangeNotifierProvider(create: (context) => HomeViewModel(), child: const HomeView()),
        '/addChat': (context) => ChangeNotifierProvider(create: (context) => AddChatViewModel(), child: const UserChooseView())
      },
    );
  }

  //Getters and setters
  MaterialApp getStartUpView(){
    return this._startUpView;
  }
}
