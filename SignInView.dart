import 'package:flutter/material.dart';
import 'package:flutter_app/views/HomeView.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/views/signInAuth.dart';
import 'package:flutter_app/scaffold.dart';


class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Center(
              child: Card(
            color: Colors.blue[200],
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Sign In To ChatAPP',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(height: 40.0),
                  RaisedButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('Sign In With GOOGLE'),
                    onPressed: () async {
                      // .timeout(Duration(seconds: 180)
                      // GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
                      // final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                      handleSignIn().whenComplete(() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return MyChatApp();
                            },
                          ),
                        );
                      });
                    },
                  ),
                  SizedBox(height: 40.0),
                  Text(
                    'By signing in, you agree to the Terms of Use and Privacy Policy',
                    style: Theme.of(context).textTheme.body2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
