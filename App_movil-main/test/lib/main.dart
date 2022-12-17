// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:test/screen/Homepage.dart';
import 'package:test/screen/Pokedex.dart';
import 'package:test/screen/Profilepage.dart';
import 'package:test/screen/Ranking.dart';
import 'package:test/screen/Loginpage.dart';

import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.jwt});

  final String title;
  final String jwt;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  bool _auth = false;
  List<Widget> get screens => [
        Profilepage(),
        Ranking(),
        Pokedex(
          jwt: widget.jwt,
        )
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
        //IndexedStack permite que no se destruyan las otras pantallas cuando se visita otra
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Ranking',
            backgroundColor: Color.fromARGB(255, 223, 202, 15),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Pokedex',
            backgroundColor: Color.fromARGB(255, 218, 1, 1),
          ),
        ],
      ),
    );
  }
}
