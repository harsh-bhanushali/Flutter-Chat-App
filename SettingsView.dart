import 'package:flutter/material.dart';
import 'package:flutter_app/views/SignInAuth.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
     child: Center(
       child: Column(
         children: <Widget>[
           RaisedButton(
             child: Text('Sign Out'),
             onPressed: (){
               handleSignOut();
             },
             )
         ],
       )
     ),
    );
  }
}