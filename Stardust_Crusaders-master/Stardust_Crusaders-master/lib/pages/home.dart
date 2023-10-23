//import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:units/main.dart';

import 'package:units/pages/settings.dart';

class HomePage extends StatefulWidget {
 // HomePage({super.key});
  HomePage({Key? key}) : super(key: key);

  List<String> facts = [];

  @override
  State<HomePage> createState() => HomePageState();
} //MyHomePage

Widget build(BuildContext context) {
  return FutureBuilder(
    // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print("couldn't connect");
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home:  HomePage(),
          );
        }
        Widget loading = MaterialApp();
        return loading;
      });
}

final databaseReference = FirebaseFirestore.instance.collection('UserName');

Future<DocumentSnapshot> retrieveData() async {
  return databaseReference.doc("Name").get();
}
//setState((){ userName = data["Name"]; )};
//Future <String> userName = switchN();
//String userName = databaseReference.doc("Name").get().toString();
//String userName = '';
//String welcomeText = 'Welcome ' + userName;
String welcomeText = userName;

void nameSwitch(String daString) async {
  userName = daString;
  databaseReference.doc("Name").set({"Name": daString});
  userName = daString;
  //welcomeText = 'Welcome ' + userName;
  welcomeText = userName;
}

class HomePageState extends State<HomePage> {
  List<String> facts = [
    'Pets can dream as well',
    'Blind people can dream visually',
    'You remember a dream if you awake during it',
    'Sleeping less than 6 hours reduces life expectancy',
    'Brains are more active during sleep than during the day',
    '12% of people dream in black and white',
    'DMT is produced naturally by our brains during dreams. Its also produced shortly before birth and death',
    'Dreams can improve your performance',
    'less stress leads to better dreams',
    'some creations have been inspired by dreams',
  ];

  List<String> meanings = [
    'dreams about loosing control could mean you have a built up anger or hostility towards a situation',
    'dreams about being late could mean you are suffering under a weight of expectations you feel you cant live up to',
    'dreams about being trapped or stuck could mean you have frustrations in your life',
    'dreams about being chased/attacked could mean you are dealing with inner conflict that you are unable to face',
    'dreams about falling could mean you lost control in an aspect of your life',
    'dreams about failing an exam could mean you feel overwhelmed or burnout',
  ];

  String randomFact = '';

  String randomMeaning = '';

  @override
  void initState() {
    super.initState();
    generateRandomFact(); // generate a random fact when the widget is initialized
    generateRandomMeaning();
    Timer.periodic(Duration(seconds: 60), (timer) {
      generateRandomFact(); // generate a new random fact every 60 seconds
      generateRandomMeaning();
    });
  }


  void generateRandomFact() {
    setState(() {
      int randomIndex = Random().nextInt(facts.length);
      randomFact = facts[randomIndex];
    });
  }

  void generateRandomMeaning() {
    setState(() {
      int randomIndex = Random().nextInt(meanings.length);
      randomMeaning = meanings[randomIndex];
    });
  }

  @override


  Widget build(BuildContext context) {
    var _welcomeView = Column(
      children: <Widget>[
        Center(
          child: Text(
            '$welcomeText',
            style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal

            ),
          ),
        ),
      ],
    );


    return Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          title: const Text('Home'),
         actions: [
          IconButton(
            icon: const Icon(Icons.settings_applications_sharp),
            tooltip: 'Open shopping cart',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingPage()) );
            },
          ),
        ],
        ),

        body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Sweet Dreams!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),

              Padding(padding: EdgeInsets.all(5.0)),
              _welcomeView,

         
              Text(
                '',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 46.0, color: Colors.blue),
              ),
              Text(
                '',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 46.0, color: Colors.blue),
              ),
              Text(
                'Did you know?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
              Text(
                randomFact,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, color: Colors.indigo),
              ),
              Text(
                '',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 46.0, color: Colors.blue),
              ),
              Text(
                '',
              ),
              Text(
                'Want to know what your dreams mean?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
              Text(
                randomMeaning,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, color: Colors.purple),
              ),
            ],
          ),
        )
    );
  }}
