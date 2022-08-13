import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your chats"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/NMfsoWaen8a7TARzk6x2/messages')
            .snapshots(),
        builder: (context, streamSnapshot) {
          //builder function is RE EXCECUTED whatever the steam gives us a new value
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[index]["text"]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection("chats/NMfsoWaen8a7TARzk6x2/messages")
              .add({"text": "this was added by clicking the button"});
        },
      ),
    );
  }
}
