import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, i) => Container(
          padding: EdgeInsets.all(10),
          child: Text('This works!'),
        ),
      ),
    );
  }
}
