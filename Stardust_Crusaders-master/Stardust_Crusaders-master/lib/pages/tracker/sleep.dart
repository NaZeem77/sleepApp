import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class SleepPage extends StatefulWidget {
  const SleepPage({super.key});

  @override
  State<SleepPage> createState() => SleepPageState();
} //MyHomePage


enum Mood {happy, sad, neutral, none}

class SleepPageState extends State<SleepPage> {
  var hourController = TextEditingController();
  var minuteController = TextEditingController();
  var yearController = TextEditingController();
  var monthController = TextEditingController();
  var dayController = TextEditingController();
  String hour = "0.0";
  String minute = "0.0";
  String year = "0.0";
  String month = "0.0";
  String day = "0.0";
  final FocusNode hourFocus = FocusNode();
  final FocusNode minuteFocus = FocusNode();
  final FocusNode yearFocus = FocusNode();
  final FocusNode monthFocus = FocusNode();
  final FocusNode dayFocus = FocusNode();
  var formKey = GlobalKey<FormState>();
  var mood = Mood.none;
  var value = 0;
  bool isGood = false;
  bool isOk = false;
  bool isBad = false;
  final databaseReference = FirebaseFirestore.instance.collection('Sweet_Dreams').doc('Sleep').collection('Info');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _mainPartView = Container(
      color: Colors.grey.shade300,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                      "Indicate below the date you want to record:",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Lucida'),
                      textScaleFactor: 1.5,
                      textAlign: TextAlign.center
                  )
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: yearFormField(context),
                  ),
                  Expanded(
                    child: monthFormField(context),
                  ),
                  Expanded(
                    child: dayFormField(context),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                      "Indicate the amount of time you slept for below:",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Lucida'),
                      textScaleFactor: 1.5,
                      textAlign: TextAlign.center
                  )
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: hourFormField(context),
                  ),
                  Expanded(
                    child: minFormField(context),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: 50.0, bottom: 15.0),
                  child: Text(
                      "How was your sleep?",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Lucida'),
                      textScaleFactor: 1.5,
                      textAlign: TextAlign.center
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // Toggle light when tapped.
                          mood = Mood.happy;
                          isGood = true;
                          isOk = false;
                          isBad = false;
                        });
                      },
                      child: isGood ? Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:  Border.all(
                            color: Colors.blue,
                            width: 5
                            ),
                        ),
                        child: Image.asset('assets/images/happy.png',
                              height: 75
                          ),
                        ) :
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Image.asset('assets/images/happy.png',
                            height: 75
                        ),
                      )
                    ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          // Toggle light when tapped.
                          mood = Mood.neutral;
                          isGood = false;
                          isOk = true;
                          isBad = false;
                        });
                      },
                      child: isOk ? Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:  Border.all(
                              color: Colors.blue,
                              width: 5
                          ),
                        ),
                        child: Image.asset('assets/images/neutral.png',
                            height: 75
                        ),
                      ) :
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Image.asset('assets/images/neutral.png',
                            height: 75
                        ),
                      )
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          // Toggle light when tapped.
                          mood = Mood.sad;
                          isGood = false;
                          isOk = false;
                          isBad = true;
                        });
                      },
                      child: isBad ? Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:  Border.all(
                              color: Colors.blue,
                              width: 5
                          ),
                        ),
                        child: Image.asset('assets/images/sad.png',
                            height: 75
                        ),
                      ) :
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Image.asset('assets/images/sad.png',
                            height: 75
                        ),
                      )
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: recordButton(),
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Sleep'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent.shade700,
        ),
        backgroundColor: Colors.white,
        body: ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(5.0)),
              _mainPartView
            ])
    );
  }

  TextFormField yearFormField(BuildContext context) {
    return TextFormField(
      controller: yearController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: yearFocus,
      onFieldSubmitted: (term){
        _fieldFocusChange(context, yearFocus, monthFocus);
        year = term.toString();
      },
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 2000 || double.parse(value) > DateTime.now().year)) {
          return ('2000 - ' + DateTime.now().year.toString());
        }
      },
      onSaved: (value) {
        year = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 6',
        labelText: 'Year',
        icon: Icon(Icons.calendar_month),
        fillColor: Colors.white,
      ),
    );
  }

  TextFormField monthFormField(BuildContext context) {
    return TextFormField(
      controller: monthController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: monthFocus,
      onFieldSubmitted: (term){
        _fieldFocusChange(context, monthFocus, dayFocus);
        month = term.toString();
      },
      validator: (value) {
        if ((int.parse(year) == DateTime.now().year) && (double.parse(value!) < 1 || double.parse(value!) > DateTime.now().month)) {
          return ('1 - ' + DateTime.now().month.toString());
        }
        else if (value!.length == 0 || (double.parse(value) < 1 || double.parse(value) > 12)) {
          return ('1 - 12');
        }
      },
      onSaved: (value) {
        month = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 6',
        labelText: 'Month',
        icon: Icon(Icons.calendar_month_outlined),
        fillColor: Colors.white,
      ),
    );
  }

  TextFormField dayFormField(BuildContext context) {
    return TextFormField(
      controller: dayController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: dayFocus,
      onFieldSubmitted: (term){
        _fieldFocusChange(context, dayFocus, hourFocus);
      },
      validator: (value) {
        if ((year == DateTime.now().year.toString()) && (month == DateTime.now().month.toString()) && (double.parse(value!) > DateTime.now().day)) {
          return ('1 - ' + DateTime.now().day.toString());
        }
        else if (value!.length == 0 || (double.parse(value) < 1 || double.parse(value) > DateTime(int.parse(year), int.parse(month) + 1, 0).day)) {
          return ('1 - ' + DateTime(int.parse(year), int.parse(month) + 1, 0).day.toString());
        }
      },
      onSaved: (value) {
        day = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 6',
        labelText: 'Day',
        icon: Icon(Icons.calendar_today),
        fillColor: Colors.white,
      ),
    );
  }

  TextFormField hourFormField(BuildContext context) {
    return TextFormField(
      controller: hourController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: hourFocus,
      onFieldSubmitted: (term){
        _fieldFocusChange(context, hourFocus, minuteFocus);
      },
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 1 || double.parse(value) > 12)) {
          return ('Hour between 1 - 12');
        }
      },
      onSaved: (value) {
        hour = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 6',
        labelText: 'Hour',
        icon: Icon(Icons.access_time_filled),
        fillColor: Colors.white,
      ),
    );
  }

  TextFormField minFormField(BuildContext context) {
    return TextFormField(
      controller: minuteController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: minuteFocus,
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 0 || double.parse(value) > 59)) {
          return ('Minute between 0 - 59');
        }
      },
      onSaved: (value) {
        minute = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 30',
        labelText: 'Minute',
        icon: Icon(Icons.access_time),
        fillColor: Colors.white,
      ),
    );
  }

  ElevatedButton recordButton() {
    return ElevatedButton(
      onPressed: storeInfo,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent.shade700,
          textStyle: TextStyle(color: Colors.white70)
      ),
      child: Text(
        'RECORD',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> storeInfo() async {
    record();
    final snap = await FirebaseFirestore.instance;
    DateTime date = DateTime(int.parse(year),int.parse(month), int.parse(day));
    Timestamp convertedDate = Timestamp.fromDate(date);
    String sleep = hour + "hr " + minute + "min";
    final data;
    //firebase store data
    switch(mood) {
      case Mood.none: {
        data = {
          "Mood": "None",
          "Time Asleep": sleep,
          "Date": convertedDate,
          "type": "Sleep",
        };
      }
      break;
      case Mood.happy: {
        data = {
          "date": convertedDate,
          "Time Asleep": sleep,
          "Mood": "Happy",
          "type": "Sleep",

        };
      }
      break;
      case Mood.neutral: {
        data = {
          "date": convertedDate,
          "Time Asleep": sleep,
          "Mood": "Ok",
          "type": "Sleep",
        };
      }
      break;

      case Mood.sad: {
        data = {
          "date": convertedDate,
          "Time Asleep": sleep,
          "Mood": "Bad",
          "type": "Sleep"
        };
      }
      break;
    }

    snap.collection("test").doc().set(data);
    // simply add a document in messages sub-collection when needed.
  }

  void record(){
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // DateTime today = DateTime.now();
      // String date = today.year.toString() + "-" + today.month.toString() + "-" + today.day.toString();
      String date = year + "-" + month + "-" + day;
      String sleep = hour + "hr " + minute + "min";
      switch(mood) {
        case Mood.none: {
          databaseReference.doc(date).set({"Time Asleep": sleep, "Quality of Sleep": "None"});
        }
        break;
        case Mood.happy: {
          databaseReference.doc(date).set({"Time Asleep": sleep, "Quality of Sleep": "Good"});
        }
        break;
        case Mood.neutral: {
          databaseReference.doc(date).set({"Time Asleep": sleep, "Quality of Sleep": "Ok"});
        }
        break;

        case Mood.sad: {
          databaseReference.doc(date).set({"Time Asleep": sleep, "Quality of Sleep": "Bad"});
        }
        break;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data Successfully Stored'),
            backgroundColor: Colors.green),
      );

    }
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,
      FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}

