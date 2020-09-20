import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chats/3Gx8l7jyDSZ2xZskwYfx/messages')
            .snapshots(),
        builder: (context, snapShots) {
          if (snapShots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapShots.data.documents;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, i) => Container(
              padding: EdgeInsets.all(10),
              child: Text(documents[i]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Firestore.instance
              .collection('chats/3Gx8l7jyDSZ2xZskwYfx/messages')
              .add({'text': 'This was added by clicking button'});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
