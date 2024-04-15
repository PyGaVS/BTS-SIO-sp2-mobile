import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selenium_chat/config/app_settings.dart';
import 'dart:developer' as developer;
import 'package:selenium_chat/view_model/addChat_view_model.dart';
import 'package:selenium_chat/model/auth.dart';
import 'package:selenium_chat/model/chat.dart';
import 'package:selenium_chat/model/user.dart';

class UserChooseView extends StatefulWidget {

  const UserChooseView({Key? key}) : super(key: key);

  @override
  State<UserChooseView> createState(){
    return UserChooseViewState();
  }
}

class UserChooseViewState extends State<UserChooseView> {

  late AddChatViewModel _acvm;

  @override
  void initState(){
    developer.log('UserChooseViewState - initState()');
    _acvm = Provider.of<AddChatViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    developer.log('UserChooseViewState - build()');
    _acvm.initBrowUsers('');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          foregroundColor: Colors.white,
          title: const Text('Ajouter un discussion'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            },
          ),
        ),
        body: Container(
            child: Consumer<AddChatViewModel>(builder : (_,acvm,__) => Expanded(
                child: RefreshIndicator(
                    onRefresh: () => acvm.browUsers(''),
                    child: FutureBuilder<List<User>>(
                        future: acvm.users,
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return const Center(child: CircularProgressIndicator(color: Colors.white));
                          } else {
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                      title: Text(snapshot.data![index].getUsername())
                                  );
                                }
                            );
                          }
                        }
                    )
                )
            ))
        )
    );
  }
}