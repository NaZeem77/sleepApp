import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class IntakePage extends StatefulWidget {
  const IntakePage({super.key});


  @override
  State<IntakePage> createState() => IntakePageState();
} //MyHomePage

 final databaseReference = FirebaseDatabase.instance.ref();

class IntakePageState extends State<IntakePage> {
 final databaseReference = FirebaseDatabase.instance.ref();


  void  _saveData() async {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Your data has been submitted.'),
          duration: Duration(seconds: 4),
        ),
    );
  }

    TextEditingController caffeineIntakeController = TextEditingController();
    TextEditingController foodIntakeController = TextEditingController();
    TextEditingController otherIntakeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Intake"),
        centerTitle: true,
        backgroundColor: Colors.teal[600],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.teal]
            )
        ),
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFormField(
              cursorColor: Colors.black,
              controller: caffeineIntakeController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.black),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 20.0),
                labelText: 'Caffeine Consumption Intake:',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                icon: Icon(Icons.coffee, color: Colors.black),
              ),
              style: TextStyle(fontSize: 20,
              ),
            ),
            TextFormField(
              cursorColor: Colors.black,
              controller: foodIntakeController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.black),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 20.0),
                labelText: 'Food Consumption Intake:',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                icon: Icon(Icons.fastfood, color: Colors.black),
              ),
              style: TextStyle(fontSize: 20
              ),
            ),
            TextFormField(
              cursorColor: Colors.black,
              controller: otherIntakeController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.black),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 20.0),
                labelText: 'Other Consumption Intake:',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                icon: Icon(Icons.no_food, color: Colors.black),
              ),
              style: TextStyle(fontSize: 20
              ),
            ),
            SizedBox(height: 30.0,),
            ElevatedButton(
              child: const Text('Record Your Intakes'),
              onPressed: () {
                recordIntakes();
                _saveData();
                },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

 Future<void> recordIntakes() async {

   final snap = await FirebaseFirestore.instance;

   //firebase store data
   final data = {
     "date": Timestamp.now(),
     "type": 'Intake',
     "caffeineIntake": caffeineIntakeController.text,
     "foodIntake": foodIntakeController.text,
     "otherIntake": otherIntakeController.text
   };

   snap.collection("test").doc().set(data);
   // simply add a document in messages sub-collection when needed.
 }
}

  final FdatabaseReference = FirebaseFirestore.instance.collection('test').doc("testdoc").collection("Date:");
  String _counter = "";







