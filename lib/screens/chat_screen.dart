import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FlutterChat'), actions: [
        DropdownButton(
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).primaryIconTheme.color,
          ),
          items: [
            DropdownMenuItem(
              child: Container(
                child: Row(children: const <Widget>[
                  Icon(Icons.exit_to_app),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Logout'),
                ]),
              ),
              value: 'logout',
            ),
          ],
          onChanged: (itemIdentifier) {
            FirebaseAuth.instance.signOut();
          },
        )
      ]),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/ZsdVjkinvW0DQrmS1Uej/message')
            .snapshots(),
        builder: (context, snapshot) {
          final documents = snapshot.data?.docs ?? [];
          return ListView.builder(
              itemCount: documents?.length,
              itemBuilder: ((ctx, index) => Container(
                    padding: EdgeInsets.all(8),
                    child: Text(documents?[index]['text']),
                  )));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/ZsdVjkinvW0DQrmS1Uej/message')
              .add({'text': 'thisdasndkjaudii'});
        },
      ),
    );
  }
}
