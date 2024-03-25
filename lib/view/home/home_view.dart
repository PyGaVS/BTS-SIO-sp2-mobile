import 'package:flutter/material.dart';
import 'package:selenium_chat/config/app_settings.dart';
import 'dart:developer' as developer;

class HomeView extends StatefulWidget {
  //Properties
  //Constructor
  const HomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    developer.log('HomeView - createState()');
    return HomeViewState();
  }

//Setters and getters
//Static methods
//Object methods

}

class HomeViewState extends State<StatefulWidget> {
  //Properties
  //late Scaffold _screen; // No constructor

  @override
  Widget build(BuildContext context) {
    developer.log('HomeViewState - build()');

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: const Text('Selenium')
        ),
        backgroundColor: AppSettings.BG_COLOR,
    );
  }
}
