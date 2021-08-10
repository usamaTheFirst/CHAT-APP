import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_chat_app/Widgets/Chat/message_bubble.dart';

class Messages extends StatelessWidget {
  Messages({Key key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapShot) {
        if (chatSnapShot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          var data = chatSnapShot.data.docs;
          return ListView.builder(
            reverse: true,
            itemBuilder: (ctx, index) {
              return MessageBubble(
                messageText: data[index]['text'],
                isMe: data[index]['userID'] == user,
                username: data[index]['username'],
                image: data[index]['image'],
                key: ValueKey(
                  data[index].id,
                ),
              );
            },
            itemCount: data.length,
          );
        }
      },
    );
  }
}
