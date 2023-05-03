import 'package:flutter/material.dart';
import './screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/auth_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: const ColorScheme.light(
            primary: Colors.pink,
            background: Colors.pink,
            secondary: Colors.deepPurple,
            brightness: Brightness.light,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )))),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('snapshot.hasData: $snapshot.hasData');
          return ChatScreen();
        }
        return AuthScreen();
      },),
    );
  }
}
