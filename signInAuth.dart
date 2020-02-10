import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> handleSignIn() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  //AUTHENTICATE USER
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

// ADD THE GOOGLE SIGN IN USER TO FIREBASE INSTANCE
  final FirebaseUser user = await _auth.signInWithGoogle(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  print("signed in " + user.displayName);
  return user;
}

Future<Null> handleSignOut() async {
  await _auth.signOut();
  await _googleSignIn.signOut();
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn googleSignIn = GoogleSignIn();

// Future<String> signInWithGoogle() async {
//   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//   final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;

//   final AuthCredential credential = GoogleAuthProvider.getCredential(
//     accessToken: googleSignInAuthentication.accessToken,
//     idToken: googleSignInAuthentication.idToken,
//   );

//   final AuthResult authResult = await _auth.signInWithCredential(credential);
//   final FirebaseUser user = authResult.user;

//   assert(!user.isAnonymous);
//   assert(await user.getIdToken() != null);

//   final FirebaseUser currentUser = await _auth.currentUser();
//   assert(user.uid == currentUser.uid);

//   return 'signInWithGoogle succeeded: $user';
// }

// void signOutGoogle() async{
//   await googleSignIn.signOut();

//   print("User Sign Out");
// }