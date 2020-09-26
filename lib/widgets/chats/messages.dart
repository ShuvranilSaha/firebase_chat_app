import 'package:chat_app/widgets/chats/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).accentColor,
            ),
          );
        }
        return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy(
                  'createdAt',
                  descending: true,
                )
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                );
              }
              final chatDocs = snapshot.data.documents;
              return ListView.builder(
                reverse: true,
                itemBuilder: (context, index) => MessageBubble(
                  chatDocs[index]['text'],
                  chatDocs[index]['userId'] == snapShot.data.uid,
                  chatDocs[index]['username'],
                  key: ValueKey(chatDocs[index].documentID),
                ),
                itemCount: chatDocs.length,
              );
            });
      },
    );
  }
}
