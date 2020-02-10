import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ChatMessage.dart';
import 'package:flutter_app/Helper.dart';

class ChatView extends StatefulWidget {
  ChatView({
    Key key,
    this.friendName: "",
    this.lastMessage: "",
    this.avatarUrl,
    this.friendId,
  }) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
  final String friendName;
  final String lastMessage;
  final String avatarUrl;
  final String friendId;
}

class _ChatViewState extends State<ChatView> {
  String _friendInitial;
  String avatarUrl;
  TextEditingController _controller = TextEditingController();
  String _message;
  List<dynamic> _listOfMessages;
  FocusNode focusChatMessage;

  @override
  void initState() {
    _listOfMessages = List();
    focusChatMessage = FocusNode();
    // TODO: implement initState
    setState(() {
      _friendInitial = widget.friendName.substring(0, 1);
    });

    super.initState();
    //Load the messages
    loadMessages(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusChatMessage.dispose();
    _controller.dispose();
    super.dispose();
  }

  void loadMessages(BuildContext context) async {
    Map<String, dynamic> tempObject =
        await loadJsonFileAsMap(context, 'assets/messageDetails.json');

    setState(() {
      _listOfMessages = tempObject[widget.friendId]['message'];
      avatarUrl = tempObject[widget.friendId]['avatar'];
    });
    print('list of messages $_listOfMessages');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friendName),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
              child: StreamBuilder(
            stream: Firestore.instance
                .collection('/message_data/friendA##friendB/message_list')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text('Error on chatView ${snapshot.error.toString()}');
              }
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  if (snapshot.data.documents .length > 0) {
                    return ListView.builder(
                      itemCount: _listOfMessages.length,
                      //  itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        // DocumentSnapshot _document = snapshot.data.documents[index];
                        // print('value of document on chat view $_document}');
                        Map<String, dynamic> _tempMessage =
                            _listOfMessages[index];
                        print('_tempMessage : $_tempMessage');
                        return ChatMessage(
                          // isFriend: _tempMessage['fromA'],
                           isFriend:true,
                          isNotPrevious: _listOfMessages.length - 1 == index,
                          // isNotPrevious:snapshot.data._documents.length - 1 == index,
                          message: _tempMessage['content'],
                          friendInitial: 
                           _tempMessage['display_name']
                              .toString()
                              .substring(0, 1),
                          // avatarUrl:'https://avatarfiles.alphacoders.com/132/132399.jpg',
                          avatarUrl:avatarUrl,
                        );
                      },
                    );

                  }
                  else{
                    return Text('No messages found in chat view length vala'); 
                  }
                }
                else{
                    return Text('No messages found in chat view hasdata'); 
                  }
              }
              else{
                return CircularProgressIndicator();
              }
            },
          )),
          // FutureBuilder(
          //   future: loadJsonFileAsMap(context, 'assets/messageDetails.json'),
          //   builder: (BuildContext context, AsyncSnapshot snapshot) {
          //     if (snapshot.connectionState == ConnectionState.done) {
          //       if (snapshot.hasData) {
          //         int _index = 0;
          //         Map<String, dynamic> tempMap = snapshot.data;
          //         List<ChatMessage> chatMessageWidgets = List();

          //         tempMap.forEach((_key, _value) {
          //           print('$_value');
          //           List<dynamic> _messageList = _value["message"];
          //           print('$_messageList');
          //           _messageList.forEach((_message) {
          //             chatMessageWidgets.add(ChatMessage(
          //               isFriend: true,
          //               isNotPrevious: tempMap.length - 1 == _index,
          //               message: _message['content'],
          //               friendInitial: 'T',
          //               avatarUrl: _value['avatar'],
          //             ));
          //             _index++;
          //           });
          //         });
          //         // List<ChatMessage> chatMessageWidgets = List();
          //         // List<dynamic> chatMessageList = snapshot.data;

          //         // chatMessageList.forEach((_message) {
          //         //   chatMessageWidgets.add(ChatMessage(
          //         //     isFriend: true,
          //         //     isNotPrevious: chatMessageList.length - 1 == _index,
          //         //     message: _message['content'],
          //         //     friendInitial: '',
          //         //   ));
          //         //   _index++;
          //         // });
          //         return ListView(
          //           children: chatMessageWidgets,
          //         );
          //       } else {
          //         return Center(child: Text('No message available'));
          //       }
          //     } else {
          //       return CircularProgressIndicator();
          //     }
          //   },
          // ),

          Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: TextFormField(
                  controller: _controller,
                  // onFieldSubmitted: (String _message) {
                  //   submitText();
                  //   print("on submit  " + _message);
                  //   Map<String, dynamic> newMessage = {
                  //     "type": "string",
                  //     "content": _message,
                  //     "from": "me",
                  //   };
                  //   List<dynamic> newList = _listOfMessages;
                  //   newList.add(newMessage);

                  //   setState(() {
                  //     _listOfMessages = newList;
                  //   });
                  //   _controller.clear();
                  // },
                  decoration: InputDecoration.collapsed(
                    hintText: "Type your message here",
                  ),
                )),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: IconButton(
                        icon: Icon(Icons.send, color: Colors.blue),

                        onPressed: () {
                          print("send " + _controller.text);
                          FocusScope.of(context).requestFocus(focusChatMessage);
                          submitText();
                          // Map<String, dynamic> newMessage = {
                          //   "type": "string",
                          //   "content": _controller.text,
                          //   "from": "me",
                          // };
                          // List<dynamic> newList = _listOfMessages;
                          // newList.add(newMessage);

                          // setState(() {
                          //   _listOfMessages = newList;
                          // });
                          // _controller.clear();
                        },

                        //     Map<String, dynamic> newMessage = {
                        //   "type": "string",
                        //   "content": _message,
                        //   "from": "me",
                        // };
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// SUBMIT THE
  void submitText() {
    print("on submit  " + _controller.text);
    //CREATE A NEW MESSAGE OBJECT FROM A TEXTFIELD
    if (_controller.text.length > 0) {
      Map<String, dynamic> newMessage = {
        "type": "string",
        "content": _controller.value.text,
        "from": "me",
      };
      // List<dynamic> newList = _listOfMessages;
      // newList.add(newMessage);
      // print(newList);
      //ADD THE NEW MESSAGE OBJECT

      try {
        _listOfMessages.add(newMessage);
        //CLEAR THE TEXT
        _controller.clear();
      } catch (e) {
        print('CHAT VIE > ERR > ${e.toString()}');
      }
      // setState(() {
      //   _listOfMessages = newList;
      // });
    }
  }

  Future<List> loadMessageDetails() async {
    String messageDetailsString = await DefaultAssetBundle.of(context)
        .loadString('assets/messageDetails.json');
    // print('message Details : $messageDetailsString');
    Map<String, dynamic> mappedMessages = json.decode(messageDetailsString);
    List<dynamic> messages = mappedMessages['12345']['message'];
    // print('list : $messages');
    messages.forEach((_value) {
      print('value is : $_value');
    });
    return messages;
  }

  List<Widget> getMessage() {
    List<Widget> tempList = List();
    tempList.add(Text('No message found'));
    loadMessageDetails().then((_value) {
      if (_value != null) {
      } else {}
    });
    return tempList;
  }
}
