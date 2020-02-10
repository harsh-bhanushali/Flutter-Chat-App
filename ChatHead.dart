import 'package:flutter/material.dart';
import 'package:flutter_app/ChatView.dart';

class ChatHead extends StatefulWidget {
  @override
  _ChatHeadState createState() => _ChatHeadState();

  /// This is the name of friend
  final String friendName;

// This text will appear below the name
  final String lastMessage;

//This will show the time when message was recieved
  final DateTime messageTime;

  final String avatar;

  final String friendId;

  ChatHead({
    Key key,
    this.friendName: "",
    this.lastMessage: "",
    this.messageTime,
    this.avatar:"", this.friendId,
  }) : super(key: key);
}

class _ChatHeadState extends State<ChatHead> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return ChatView(
                friendName: widget.friendName,
                lastMessage: "Snap",
                friendId: widget.friendId,
              );
            }, 
            fullscreenDialog: true));
      },
      highlightColor: Colors.blue,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        width: double.infinity,
        height: 100.0,
        // color: Colors.grey[300],
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.friendName,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    widget.lastMessage,
                    style: Theme.of(context).textTheme.body2,
                  ),
                  Text(widget.messageTime.toString()),
                ],
              ),
            ),
            CircleAvatar(
              radius: 32.0,
              backgroundImage: Image.network(widget.avatar).image,
              child:
              widget.avatar != ""
              ? Text(
                widget.friendName.substring(0, 1),
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .apply(color: Colors.white, fontWeightDelta: 3),

              )
              :Container(), 
            ),
          ],
        ),
      ),
    );
  }
}
