import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/track.dart';
import 'pages/calendar/calendar.dart';
import 'pages/settings.dart';
import 'pages/home.dart';
import 'pages/calc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


String userName = '';

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  DocumentSnapshot data = await retrieveData();

  userName = data["Name"];
  runApp(MyApp());
}



class MyApp extends StatelessWidget {

  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }


}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  late FirebaseMessaging messaging;
  @override
  void initState() {
    super.initState();

    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print('Toekn VALUE =====  $value 199999923123END TOKEN VALUE');
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });

  }

  int _tappedIndex = 0;
  final pages = [
    HomePage(),
    TrackPage(),
    CalcPage(),
    CalenderPage(),
    SettingPage(),
  ];

  void _onItemSelected (int index) {
    setState(() {
      _tappedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[_tappedIndex],

      bottomNavigationBar:

      new Theme(
        data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
        textTheme: Theme
            .of(context)
            .textTheme
            .copyWith(caption: new TextStyle(color: Colors.red))), // sets the inactive color of the `BottomNavigationBar`
    child: new BottomNavigationBar(
        elevation: 0,
        items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.my_library_books_outlined),
          label: 'Track',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calculate),
          label: 'Calculator',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_note_rounded),
          label: 'Calendar',
        ),

        ],
        currentIndex: _tappedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        onTap: _onItemSelected,
      ),



      )
    );
  }
}

