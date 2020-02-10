import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ChatView.dart';

class ChatMessage extends StatefulWidget {
  @override
  _ChatMessageState createState() => _ChatMessageState();

  /// Whether message come from a friend
  final bool isFriend;

  /// Freinds Initial to show in avatar
  final String friendInitial;

  /// Whether the message was last message
  final bool isNotPrevious;

  /// Actual message
  final String message;

  final String avatarUrl;

  ChatMessage({
    Key key,
    this.isFriend: false,
    this.isNotPrevious: false,
    this.message: "",
    this.friendInitial: "",
    this.avatarUrl: "",
  }) : super(key: key);
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      // height: 100.0,
      width: double.infinity,
      color: Colors.grey[300],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 40.0,
            child: widget.isFriend && widget.isNotPrevious
                ? CircleAvatar(
                  backgroundImage: Image.network(widget.avatarUrl).image,                   
                    radius: 18.0,
                    backgroundColor: Colors.white,
                    child: Text(widget.friendInitial),
                  )
                : Container(),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(widget.message),
            ),
          ),
          SizedBox(
            width: 40.0,
            child: !widget.isFriend && widget.isNotPrevious
                ? CircleAvatar(
                    backgroundImage: Image.network(widget.avatarUrl).image,
                    radius: 18.0,
                    backgroundColor: Colors.white,
                    child: Text("Me"),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
