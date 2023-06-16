import 'package:flutter/material.dart';
import 'package:sqllite/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tambahkan Item - AgustD| 1234567',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const Home(),
    );
  }
}