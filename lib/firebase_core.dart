import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Auto_screen.dart'; // Import the file where AuthScreen is defined

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(), // Now AuthScreen is correctly referenced
    );
  }
}
