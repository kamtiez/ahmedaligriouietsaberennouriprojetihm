import 'package:firebase_core/firebase_core.dart';
import 'package:flip_box_bar_plus/flip_box_bar_plus.dart';
import 'package:flutter/material.dart';
import 'package:gestion_articles/pages/AjouterArticle.dart';
import 'package:gestion_articles/pages/Articles.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAitF0R2nEZFmumZQlmwvV2sqOykVrAR-I",
          authDomain: "log-time-6af3d.firebaseapp.com",
          projectId: "log-time-6af3d",
          storageBucket: "log-time-6af3d.appspot.com",
          messagingSenderId: "382962311589",
          appId: "1:382962311589:web:03ece08f0603e141dc884c",
          measurementId: "G-5SEEBPH314"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  final screens = [AjouterArticle(), Articles()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex], //
      bottomNavigationBar: FlipBoxBarPlus(
        selectedIndex: selectedIndex,
        items: [
          FlipBarItem(
              icon: const Icon(Icons.add),
              text: const Text("Ajouter"),
              frontColor: Colors.cyan,
              backColor: Colors.cyanAccent),
          FlipBarItem(
              icon: const Icon(Icons.print),
              text: const Text("Articles"),
              frontColor: Colors.pink,
              backColor: Colors.pinkAccent),
        ],
        onIndexChanged: (newIndex) {
          setState(() {
            selectedIndex = newIndex;
            //print(selectedIndex);
          });
        },
      ),
    );
  }
}
