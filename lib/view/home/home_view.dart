import 'package:flutter/material.dart';
import 'package:selenium_chat/view/component/nav_drawable_widget.dart';
import 'package:selenium_chat/config/app_settings.dart';
import 'dart:developer' as developer;
import 'package:provider/provider.dart';
import 'package:selenium_chat/view/home/chats/chat_browse_view.dart';

import 'package:selenium_chat/view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  //Properties
  //Constructor
  const HomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeViewState();
  }

//Setters and getters
//Static methods
//Object methods

}

class HomeViewState extends State<StatefulWidget> {
  //Properties
  //late Scaffold _screen; // No constructor
  late HomeViewModel _hvm;

  @override
  void initState(){
    developer.log('HomeViewState - initState()');
    _hvm = Provider.of<HomeViewModel>(context, listen: false);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    developer.log('HomeViewState - build()');
    _hvm.initBrowChats();

    return DefaultTabController(length: 2,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.deepPurpleAccent,
              foregroundColor: Colors.white,
              title: const Text('Selenium'),
              bottom: const TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.forum_sharp, color: Colors.white)),
                    Tab(icon: Icon(Icons.group_sharp, color: Colors.white)),
                  ]
              )

          ),
          backgroundColor: AppSettings.BG_COLOR,
          body: const TabBarView(
            children: <Widget>[
              Column(
                children: [ChatBrowseView()],
              ),
              Column(
                children: [
                  Text('Mes amis', style: TextStyle(color: Colors.white))
                ]
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white,
            splashColor: Colors.deepPurpleAccent,
            child: const Icon(Icons.add_comment),
            onPressed: (){
              Navigator.pushNamedAndRemoveUntil(context, '/addChat', (route) => false);
            },
          ),
          drawer: const NavDrawableWidget()
      )
    );

  }
}
