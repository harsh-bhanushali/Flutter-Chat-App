import 'package:flutter/material.dart';
import 'package:flutter_app/ChatMessage.dart';
import 'package:flutter_app/Helper.dart';
import '../ChatHead.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatHistory extends StatefulWidget {
  @override
  _ChatHistoryState createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  @override
  Widget build(BuildContext context) {
    // Map<String,dynamic> mapOfChats = loadJsonFileAsMap(context, 'assets/recentChats.json');

    return Container(
      child: Center(
        child: StreamBuilder(

          //TODO: MAKE THIS DYNAMIC
          stream: Firestore.instance.collection('/message_data/friendA##friendB/message_list').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasError) return Text('error has occured : ${snapshot.error.toString()}');
            if(snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData){
                print('DATA ${snapshot.data}');
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context,int index){
                    DocumentSnapshot _data = snapshot.data.documents[index];
                    print('data ${_data['fromA']}');
                    return ChatMessage(
                      isFriend: _data['fromA'] ,
                      isNotPrevious: true,
                      message: _data['content'],
                      avatarUrl: 'https://avatarfiles.alphacoders.com/132/132399.jpg',
                      friendInitial: 'friend',
                  );
                  },
                  );
              }
              else{
                return Text('No message found');
              }
            }  else{
              return CircularProgressIndicator();
            }

          },

        )
        // FutureBuilder(
        //   future: loadJsonFileAsMap(context, 'assets/recentChats.json'),
        //   builder: (BuildContext context, AsyncSnapshot snapshot){

        //     List<ChatHead> tempList = List();
        //     if(snapshot.connectionState == ConnectionState.done){
        //       if(snapshot.hasData){
        //         Map<String,dynamic> tempMap = snapshot.data;
        //         tempMap.forEach((_key,_value){
                  
        //           DateTime messageTime = DateTime.fromMillisecondsSinceEpoch(_value['last_message']['timestamp']);
        //           tempList.add(ChatHead(
        //             friendName: _value["display_name"], 
        //             messageTime: messageTime,
        //             lastMessage: _value["last_message"]["content"],
        //             friendId: _key,
        //             avatar: _value["avatar"],

        //           )
        //           );


        //         });
        //         return ListView(children: tempList);
        //       }
        //       else{
        //         return Text("chats not found");
        //       }
        //     }
        //     else{
        //       return CircularProgressIndicator();
        //     }
            
        //   },
        // )
        // child: 
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
      ),
    );
  }
}
