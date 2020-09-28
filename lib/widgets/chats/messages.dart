import 'package:chat_app/widgets/chats/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapShot.data.docs;
        return ListView.builder(
          itemBuilder: (ctx, index) => MessageBubble(
            chatDocs[index].data()['text'],
            chatDocs[index].data()['userId'] == user.uid,
            chatDocs[index].data()['username'],
            chatDocs[index].data()['userImage'],
            key: ValueKey(chatDocs[index].id),
          ),
          reverse: true,
          itemCount: chatDocs.length,
        );
      },
    );
  }
}
