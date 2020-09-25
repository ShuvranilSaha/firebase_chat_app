import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('chat').snapshots(),
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
          itemBuilder: (context, index) => Text(chatDocs[index]['text']),
          itemCount: chatDocs.length,
        );
      },
    );
  }
}
