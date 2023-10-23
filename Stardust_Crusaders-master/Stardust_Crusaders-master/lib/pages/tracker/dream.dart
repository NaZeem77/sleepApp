import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:units/pages/calendar/calendar.dart';



class DreamPage extends StatefulWidget {
  const DreamPage({Key? key}) : super(key: key);


  @override
  State<DreamPage> createState() => DreamPageState();
}//MyHomePage

class DreamPageState extends State<DreamPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

var _selectedOption1;
var _selectedOption2;
var _selectedOption3;
var _selectedOption4;
var _selectedOption5;

List<String> _options = [
  '0',
  '1',
  '2',
  '3',
];
  void _saveData() async {

    final data = {
      'type': 'Dream',
      'nightmares': _selectedOption1,
      'normal_dreams': _selectedOption2,
      'lucid_dreams': _selectedOption3,
      'day_dreams': _selectedOption4,
      'false_awakenings': _selectedOption5,
      'date': Timestamp.now(),
    };

    await _firestore.collection('test').doc().set(data);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Your data has been submitted'),
        duration: Duration(seconds: 2),
      ),
    );
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.cyan,
    appBar: AppBar(
      title: const Text('Sleep'),
    ),

    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.cyan]
        ),
      ),


      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'select the amount of nightmares you had',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _options
                .asMap()
                .map((index, option) => MapEntry(
                index,
                Expanded(
                  child: RadioListTile(
                    title: Text(option),
                    value: index,
                    groupValue: _selectedOption1,
                    onChanged: (value) {
                      setState(() {
                      _selectedOption1 = value;
                    });
                  },
                  ),
                )))
                .values
                .toList(),
          ),
          Text(
            'select the amount of normal dreams you had',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _options
                .asMap()
                .map((index, option) => MapEntry(
                index,
                Expanded(
                  child: RadioListTile(
                    title: Text(option),
                    value: index,
                    groupValue: _selectedOption2,
                    onChanged: (value) {
                      setState(() {
                      _selectedOption2 = value;
                    });
                  },
                ),
                )))
                .values
                .toList(),
          ),
          Text(
            'select the amount of lucid dreams you had',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _options
                .asMap()
                .map((index, option) => MapEntry(
                index,
                Expanded(
                  child: RadioListTile(
                    title: Text(option),
                    value: index,
                    groupValue: _selectedOption3,
                    onChanged: (value) {
                      setState(() {
                      _selectedOption3 = value;
                      });
                    },
                  ),
                )))
                .values
                .toList(),
          ),
          Text(
            'select the amount of day dreams you had',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _options
                .asMap()
                .map((index, option) => MapEntry(
                index,
                Expanded(
                  child: RadioListTile(
                    title: Text(option),
                    value: index,
                    groupValue: _selectedOption4,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption4 = value;
                      });
                    },
                  ),
                )))
                .values
                .toList(),
          ),
          Text(
            'select the amount of false awakenings you had',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _options
                .asMap()
                .map((index, option) => MapEntry(
                index,
                Expanded(
                  child: RadioListTile(
                    title: Text(option),
                    value: index,
                    groupValue: _selectedOption5,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption5 = value;
                      });
                    },
                  ),
                )))
                .values
                .toList(),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _saveData();
              },
              child: Text('Submit'),
            ),
          ),
        ],
        
      ),
    ),
  );
}
}

DateTime today = DateTime.now();
DateTime now = DateTime(today.year, today.month, today.day);
int curYear = today.year;
int curMonth = today.month;
int curDay = today.day;
String curDate = today.toString();
