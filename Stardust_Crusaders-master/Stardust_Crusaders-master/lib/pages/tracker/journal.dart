import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
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
              home: const JournalPage(title: 'UMD Messaging App'),
            );
          }
          Widget loading = MaterialApp();
          return loading;
        });
  }
}

class JournalPage extends StatefulWidget {
  const JournalPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;


  @override
  State<JournalPage> createState() => JournalPageState();
}

final databaseReference = FirebaseDatabase.instance.ref();
List<Widget> Messages = [];

class JournalPageState extends State<JournalPage> {
  final databaseReference = FirebaseDatabase.instance.ref();
  List<Widget> Messages = [];

  int _counter = 0;


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    databaseReference.onChildAdded.listen((DatabaseEvent event) {
      final String sender = event.snapshot.children.first.value.toString();
      final String message = event.snapshot.children.last.value.toString();
      addMessage(sender, message);
    });
  }

  void addMessage(String sender, String message) {
    //print(sender + ": " + message);
    setState(() {
      final String formattedMessage = sender + "" + message;
      Text messageWidget = Text(
        formattedMessage,
        style: TextStyle(fontSize: 20),
      );
      Messages.add(messageWidget);
    });


  }

  void sendMessage(String message) async {

    String name = curDate;
    databaseReference.push().set({'Sender': name, 'message': message});

    final data = {
      'type': 'Journal',
      'message': message,
      'date': Timestamp.now(),
    };

    FdatabaseReference.doc().set(data);

  /*  FdatabaseReference.doc(today.toString()).set(
        {"Date": FieldValue.serverTimestamp(), "Entry": message});*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.lightGreen,
      ),
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText2!,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                            child: Column(
                              children: Messages,
                            )),
                      ),
                      Container(
                        height: 120.0,
                        alignment: Alignment.center,
                        child: TextField(
                          onSubmitted: (String value) async {
                            sendMessage(value);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Sleep Journal',
                              hintText: 'Whats going on?'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Future<DocumentSnapshot> retrieveData() async {
  return FdatabaseReference.doc("Sleep Journal").get();
}

Future<void> getDate() async {
  DocumentSnapshot data = await retrieveData();
  //print(data.data().toString());
  lasDate = data.data().toString();

}

DateTime today = DateTime.now();
DateTime now = DateTime(today.month, today.day, today.year);
int curYear = today.year;
int curMonth = today.month;
int curDay = today.day;
//String curDate = today.toString();
String lasDate = "";

String curDate = curMonth.toString() + "/" + curDay.toString() + "/" + curYear.toString() + "\n";
String zDate = curMonth.toString() + "/" + curDay.toString() + "/" + curYear.toString();
String daDate = curMonth.toString() + "-" + curDay.toString() + "-" + curYear.toString();

final FdatabaseReference = FirebaseFirestore.instance.collection('test');//.doc("Sleep Journal").collection("Date:");
int day = 0;
String i = day.toString();


//String curDate = "${today.day}-${today.month}-${today.year}";
//String curDate = now.toString();



/*
class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => JournalPageState();
} //MyHomePage

class JournalPageState extends State<JournalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
      ),
    );
  }

}
*/

