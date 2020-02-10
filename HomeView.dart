import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<DocumentSnapshot> getDocument() async {
    //   var document = await Firestore.instance.document('user_data/3vIf92LIJQ7pu7MpUwH1').get();
    //   print(document);

    //   DocumentReference userReference = document['display_name'];
    //    DocumentSnapshot userRef = await userReference.get();
    return Firestore.instance
        .collection('user_data')
        .document('3vIf92LIJQ7pu7MpUwH1')
        .get();
    //   return userRef;
  }

  @override
  Widget build(BuildContext context) {
//     var document = await Firestore.instance.document('COLLECTION_NAME/TESTID1');
//     document.get() => then(function(document) {
//     print(document('name'));
// }

    // StreamBuilder(
    //     stream: Firestore.instance.collection('user_data').document('display_name').snapshots(),
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) {
    //         return new Text("Loading");
    //       }
    //       var userDocument = snapshot.data;
    //       return new Text(userDocument["name"]);
    //     }
    // );

    return Container(
      child: Center(
          child: FutureBuilder(
            // future: getDocument() ,
            // builder: (BuildContext context, AsyncSnapshot snapshot) {

            // },
        future: getDocument(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) return Text(' Error: ${snapshot.error}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                SizedBox(height: 40.0),
                Text(snapshot.data['display_name'], style: Theme.of(context).textTheme.headline,),
              ],
            );
          }
        },
      )),
    );
  }
}
