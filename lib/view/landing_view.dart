import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:shared_preferences/shared_preferences.dart';


class LandingView extends StatefulWidget {

  @override
  LandingViewState createState() => LandingViewState();
}

class LandingViewState extends State<LandingView> {
  //Widget init
  @override
  void initState() {
    developer.log('LandingViewState - initState()');
    super.initState();
    //Few seconds of duration for the view
    Timer(const Duration(seconds: 6), _runApp);
  }

  _runApp() {
    _routeFirstView();
  }

  //Test of an already existing connection
  void _routeFirstView() async {
    developer.log('landingViewState - _routeFirstView()');
    //Get the shared preferences of the application
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    //Get the value of the userId key and if it is null set it to 0
    //prefs.setInt('userId', 0);
    //int userId = (prefs.getInt('userId') ?? 0);
    /*
    if (await Auth.isUserConnected()) {
      developer.log('LandingViewState - _routeFirstView() : User was already connected');
      // Go to HomeView
      Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/home'));
    } else {
      developer.log('LandingViewState - _routeFirstView() : User wasn\'t connected');
      // Go to LoginView
      Navigator.pushNamedAndRemoveUntil(context, '/login', ModalRoute.withName('/login'));
    }
    */
    Navigator.pushNamedAndRemoveUntil(context, '/login', ModalRoute.withName('/login'));
  }

  // Widget building
  @override
  Widget build(BuildContext context) {
    developer.log('LandingViewState - build()');
    final applicationName = Container(
        color: Colors.deepPurpleAccent,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        margin: EdgeInsets.all(15),
        child: const Text('Selenium', style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.white)
        )
    );

    final applicationLogo = '';

    const circularIndicator = Center(child: CircularProgressIndicator(color: Colors.deepPurpleAccent));

    return Scaffold(
        backgroundColor: Color.fromRGBO(38, 38, 38, 1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            applicationName,
            circularIndicator
          ],
        )
    );
  }


}