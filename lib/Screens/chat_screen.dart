import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('/chats/KrTaIbwmMnsQ39T9mNJW/messages')
            .snapshots(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          var docs = snapShot.data.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(
                docs[index]['text'],
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('/chats/KrTaIbwmMnsQ39T9mNJW/messages')
                .add({'text': DateTime.now().minute.toString()});
          }),
    );
  }
}
