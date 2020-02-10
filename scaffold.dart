import 'package:flutter/material.dart';
import 'package:flutter_app/ChatHead.dart';
import 'package:flutter_app/ChatView.dart';
import 'package:flutter_app/views/ChatHistory.dart';
import 'package:flutter_app/views/HomeView.dart';
import 'package:flutter_app/views/SettingsView.dart';
import 'package:flutter_app/views/SignInView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class MyChatApp extends StatefulWidget {
  @override
  _MyChatAppState createState() => _MyChatAppState();
}

class _MyChatAppState extends State<MyChatApp> {
  int _currentIndex = 0;
  bool isSignedIn = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;




  // final FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  void initState() {
    
    _auth.onAuthStateChanged.listen((_user){
      print('user has logged in  $_user');
      if(_user != null){
        //  A USER HAS SIGNED IN
        setState(() {
          isSignedIn = true;  
        });
      } 
      else{
        //a USER HAS SIGNED OURT 
        setState(() {
          isSignedIn = false; //USER IS NULL  
        });
      }
    });
    // super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(                                                 
      home: !isSignedIn
          ? SignInView()
          : Scaffold(
              appBar: AppBar(
                title: Text("Chat App "), 
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.help),
                    onPressed: () {
                      print("button pressed");
                    },
                  )
                ],
              ),
              body: selectedScreen(_currentIndex),
              // ListView(
              //   children: <Widget>[
              //     ChatHead(
              //       friendName: "Hariom",
              //       lastMessage: "Okay",
              //       messageTime: DateTime.now(),
              //     ),
              //     ChatHead(
              //       friendName: "Siddhivinayk",
              //       lastMessage: "Done",
              //       messageTime: DateTime.now(),
              //     ),
              //     // ChatHead(),
              //     // ChatHead()
              //   ],
              // ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), title: Text("Home")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.mail_outline), title: Text("Chats")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), title: Text("Settings"))
                ],
                onTap: (int index) {
                  print("index is " + index.toString());
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  print("FAB was pressed");
                },
                child: Icon(Icons.add),
              ),
            ),
      // home: ChatView(),
    );
  }

  Widget selectedScreen(int _index) {
    switch (_index) {
      case 0:
        return HomeView();
        break;
      case 1:
        return ChatHistory();
        break;
      case 2:
        return SettingsView();
        break;
      default:
        return HomeView();
    }
  }
}
