import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chats")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> chatsSnapshot) {
          if (chatsSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final chatDocs = chatsSnapshot.data.docs;
          return ListView.builder(
            reverse: true, //scrol from the bottom to the top
            itemCount: chatDocs.length,
            itemBuilder: (context, index) => MessageBubble(
              chatDocs[index]["text"],
              chatDocs[index]["userId"] ==
                  FirebaseAuth.instance.currentUser.uid,
            ),
          );
        });
  }
}
