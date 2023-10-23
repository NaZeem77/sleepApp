/**
 * Adapted from https://github.com/lohanidamodar/flutter_events_2023/tree/p3-optimization-and-more
 */

import 'dart:collection';

import 'package:flutter/gestures.dart';
import 'package:units/dreams/views/dream_easter/i_have_a_dream.dart';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:units/pages/calendar/event.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => CalenderPageState();
} //MyHomePage


class CalenderPageState extends State<CalenderPage> {

  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<Event>> _events;

  static const barColor = const Color(0xff005660);
  static const backgroundColor = const Color(0xff335068);

  static const topColor = const Color(0xffe4ffff);
  static const bottomColor = const Color(0xff007475);

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _loadFirestoreEvents();
    _testPrint();
  }

  _testPrint() { print ('TEST PRINT THING YES INITSTATE'); }

  _loadFirestoreEvents() async {
    print('LOADFIRESTOREEVENTS SUCCESSFUL');
    final snap = await FirebaseFirestore.instance
        .collection('test')
        .withConverter(
        fromFirestore: Event.fromFirestore,
        toFirestore: (event, options) => event.toFirestore())
        .get();
    for (var _event in snap.docs) {
      if (_event != null) {
        final event = _event.data();
        final day = DateTime.utc(
            event.date.year, event.date.month, event.date.day);

        if (_events[day] == null) {
          print('FAILFAILFAILFAILFAILFAILFAILFAILFAILFAILFAIL');
          _events[day] = [];
        }
        _events[day]!.add(event);
        print('-- EVENT ADDED -- EVENT ADDED -- EVENT ADDED -- ');
      }
      setState(() {});
    }
  }

  List _getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  static const barColor = const Color(0xff28899e);
      //  static const backgroundColor = const Color(0xff262624);
      backgroundColor: backgroundColor,
      appBar:
        AppBar(
          backgroundColor: barColor,
          title: RichText(
              text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Calendar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                        ),
                        recognizer: LongPressGestureRecognizer()
                          ..onLongPress = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const EasterPage()) );
                          }),
                  ]
              ),
            ),
        ),
      body:
          Container(
            decoration: BoxDecoration(
             /* image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/FunkyDKC2.webp'),
              ),                  */
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [topColor, bottomColor]
              )
            ),
            child:
            ListView(
              children: [
                TableCalendar(
                  eventLoader: _getEventsForTheDay,
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  focusedDay: _focusedDay,
                  firstDay: _firstDay,
                  lastDay: _lastDay,
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                  },
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                  onDaySelected: (selectedDay, focusedDay) {
                    print(_events[selectedDay]);
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: const CalendarStyle(
                    weekendTextStyle: TextStyle(
                      color: Colors.red,
                    ),
                    selectedDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.red,
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    headerTitleBuilder: (context, day) {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(day.toString()),
                      );
                    },
                  ),
                ),
                ..._getEventsForTheDay(_selectedDay).map(
                      (event) =>
                      Container(
                        child: Column(
                            children: [

                              ExpansionTile(
                                title: Text(event.type),
                                subtitle: Text( event.date.toString() ),
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        // Sleep
                                        if (event.time_asleep != null)
                                          Text("Time Asleep: " + event.time_asleep.toString()),
                                        if (event.mood != null)
                                          Text("Mood: " + event.mood.toString()),

                                        // Dreams
                                        if (event.normal_dreams != null)
                                          Text( "Amount of normal dreams: " + event.normal_dreams.toString() ),
                                        if (event.lucid_dreams != null)
                                          Text( "Amount of lucid dreams: " + event.lucid_dreams.toString() ),
                                        if (event.day_dreams != null)
                                          Text("Amount of day dreams: " + event.day_dreams.toString()),
                                        if (event.nightmares != null)
                                          Text( "Amount of nightmares: " + event.nightmares.toString()),
                                        if (event.false_awakenings != null)
                                          Text("Amount of false awakenings: " + event.false_awakenings.toString()),

                                        // Intake
                                        if (event.caffeineIntake != null)
                                          Text("Amount of Caffeine: " + event.caffeineIntake),
                                        if (event.foodIntake != null)
                                          Text("Food Intake: " + event.foodIntake),
                                        if (event.otherIntake != null)
                                          Text("Other Sources: " + event.otherIntake),

                                        // Journal
                                        if (event.message != null)
                                          Text("Message: " + event.message.toString()),

                                        // Text('\n')
                                      ],
                                    ),
                                  ),

                                ],
                              ),


                            ]),
                      ),

                ),
              ],
            ),
          )
    );
  }

}