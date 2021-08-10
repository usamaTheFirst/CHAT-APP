import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key key}) : super(key: key);

  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  String userMessage = '';
  final _cont = TextEditingController();

  _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    // if (userMessage.isNotEmpty)
    FirebaseFirestore.instance.collection('chat').add({
      'text': userMessage,
      "time": Timestamp.now(),
      'userID': user.uid,
      'username': user.displayName,
      'image': user.photoURL
    });

    setState(() {
      userMessage = '';
      _cont.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _cont,
              decoration: InputDecoration(labelText: "Send a message..."),
              onChanged: (text) {
                setState(() {
                  userMessage = text;
                });
              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.send),
              color: Theme.of(context).primaryColor,
              onPressed: userMessage.trim().isEmpty ? null : _sendMessage)
        ],
      ),
    );
  }
}
