import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;
import 'package:selenium_chat/config/app_settings.dart';
import 'package:selenium_chat/view_model/login_view_model.dart';

class LoginView extends StatefulWidget {
  //Properties

  //Constructor
  const LoginView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginViewState();
  }

//Getters and setters

//Static methods

//Object methods
}

class LoginViewState extends State<StatefulWidget> {
  //Properties

  late Scaffold _screen; //No constructor
  // Get or set the text value of the username and password widgets
  final TextEditingController _tecUsername = TextEditingController();
  final TextEditingController _tecPassword = TextEditingController();

  // The ViewModel that is used for data and commands binding
  late LoginViewModel _lvm;

  @override
  void initState(){
    developer.log('LoginViewState - initState()');
    // Get the instance of the LoginViewModel already created in the routes
    _lvm=Provider.of<LoginViewModel>(context, listen: false);
    // Flutter doc: init parent class always at the end of this method
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(AppSettings.APP_DEBUG){
      _tecUsername.text = 'usersio';
      this._tecPassword.text = '12345678';
    }
    developer.log('LoginViewState - build()');

    final applicationName = Container(
        //color: Colors.deepPurpleAccent,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.deepPurpleAccent
        ),
        child: const Text('Selenium', style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.white)
        )
    );
    final title = Container(
      padding: const EdgeInsets.fromLTRB(130, 10, 130, 10),
      child : const Text('Connexion', style: TextStyle(fontSize: 30, color: Colors.white)),
    );

    final username = Container(
        padding: const EdgeInsets.all(0),
        child: TextFormField(
          controller: this._tecUsername,
          style: const TextStyle(color: Colors.white),
          autofocus: true,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.tag_sharp, color: Colors.grey),
            labelText: 'Mot de passe',
            border: OutlineInputBorder(),
          ),
        ));

    final password = Container(
        padding: const EdgeInsets.all(0),
        child: TextFormField(
          controller: _tecPassword,
          style: const TextStyle(color: Colors.white),
          obscureText: true,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.lock_sharp, color: Colors.grey),
            labelText: 'Mot de passe',
            border: OutlineInputBorder(),
          ),
        ));

    final submit = ElevatedButton(onPressed: (){
      developer.log("LoginView - Username ${_tecUsername.text} / Password ${_tecPassword.text}");
      Future<bool> isUserConnected = _lvm.signInButtonOnClickCommand(_tecUsername.text, _tecPassword.text);

      isUserConnected.then((resp){
        if (resp){
          //Go to home view
          developer.log("user valid :");
          _lvm.getUser();
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else {
          developer.log("failed credentials");
        }
      });
    },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
      child: const Text('Se connecter'),
    );

    final space = Container(
        height: 19
    );

    return Scaffold(
        backgroundColor: AppSettings.BG_COLOR,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            applicationName,
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                title,
                Container (
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child : Form(
                      child: Column(
                          children: <Widget>[
                            space,
                            username,
                            space,
                            password,
                            space,
                            submit,
                          ]),
                    )),
              ],
            )
          ],
        ));
    return this._screen;
  }

}
