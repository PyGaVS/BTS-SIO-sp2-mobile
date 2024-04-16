import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selenium_chat/app.dart';
import 'package:selenium_chat/config/app_settings.dart';
import 'dart:developer' as developer;
import 'package:selenium_chat/view/home/chats/chat_add_view.dart';
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
  final List<int> _idUsers = [];

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
    final TextEditingController _tecSearch = TextEditingController();

    return Scaffold(
      backgroundColor: AppSettings.BG_COLOR,
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
        body: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(8.0),
                  color: AppSettings.BG_COLOR,
                  child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _tecSearch,
                            style: const TextStyle(color: Colors.white),
                            onChanged: (text){
                              _acvm.browUsers(text);
                            },
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Rechercher'
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        IconButton(
                            onPressed: (){
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => ChatAddView(acvm: _acvm, users: _idUsers)
                                );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            ),
                            icon: const Icon(Icons.send_sharp)),
                      ]
                  )
              ),
              Container(height: 20, color: AppSettings.BG_COLOR,),
              Expanded(
                  child: Container(
                      color: AppSettings.BG_COLOR2,
                      child: Consumer<AddChatViewModel>(builder : (_,acvm,__) => RefreshIndicator(
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
                                            return CheckboxListTile(
                                                title: Text(
                                                    snapshot.data![index].getUsername(),
                                                    style: const TextStyle(color: Colors.white)
                                                ),
                                                value: _idUsers.contains(snapshot.data![index].getId()),
                                                activeColor: Colors.deepPurpleAccent,
                                                onChanged: (bool? value){
                                                  setState(() {
                                                    if(value != null && value){
                                                      _idUsers.add(snapshot.data![index].getId());
                                                    } else {
                                                      _idUsers.remove(snapshot.data![index].getId());
                                                    }
                                                  });
                                                },
                                            );
                                          }
                                      );
                                    }
                                  }
                              )
                          )
                      )
                  )
              )

            ],
        )
    );
  }
}