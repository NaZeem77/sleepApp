import 'package:flutter/material.dart';
import 'home.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => SettingPageState();
} //MyHomePage

class SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {

    var settingText =
    Column(
      children: [
         SizedBox(
          height: 30,
        ),
        TextField(
          onSubmitted: (String value) async {
            daNewName = value;
    },
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal)),
            labelText: 'What is your name?',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            minimumSize: const Size.fromHeight(50), // NEW
          ),
          onPressed: () {nameSwitch(daNewName);},
          child: const Text(
            'Submit',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5.0)),
            settingText
          ],
        ),
      ),
    );
  }

}

String daNewName = '';
