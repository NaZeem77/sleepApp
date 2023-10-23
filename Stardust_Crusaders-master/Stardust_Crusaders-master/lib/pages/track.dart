import 'package:flutter/material.dart';
import 'package:units/pages/tracker/dream.dart';
import 'package:units/pages/tracker/intake.dart';
import 'package:units/pages/tracker/sleep.dart';
import 'package:units/pages/tracker/journal.dart';

class TrackPage extends StatefulWidget {
  const TrackPage({super.key});

  @override
  State<TrackPage> createState() => TrackPageState();
} //MyHomePage

class TrackPageState extends State<TrackPage> {

  static const topColor = const Color(0x11B589D6);
  static const bottomColor = const Color(0x11552586);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Track'),
      ),
      body:
      Center(
        child:

        Container(
          decoration: BoxDecoration(
            /*gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [topColor, bottomColor]
            ),*/
          ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child:

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Padding(
                        padding: EdgeInsets.all(8),
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child:
                          ElevatedButton(
                            child:
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/img_546686.png'),
                                  opacity: 0.25,
                                ),
                              ),
                              child:
                              Center(
                                child: Text(
                                  'Sleep',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0
                                  ),
                                ),
                              ),
                            ),
                              style:
                                ElevatedButton.styleFrom(
                                  primary: Colors.teal,
                                ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SleepPage()) );
                              },
                            )
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child:
                          ElevatedButton(
                            child:
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/3964004-200.png'),
                                  opacity: 0.25,
                                ),
                              ),
                              child:
                              Center(
                                child: Text(
                                  'Dreams',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0
                                  ),
                                ),
                              ),
                            ),
                              style:
                                ElevatedButton.styleFrom(
                                  primary: Colors.teal,
                                ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const DreamPage()) );
                              },
                            ),
                        ),
                      )

                    ],
                  ),
                ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child:
                    ElevatedButton(
                      child:
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/beverage.png'),
                            opacity: 0.25,
                          ),
                        ),
                        child:
                        Center(
                          child: Text(
                            'Intake',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0
                            ),
                          ),
                        ),
                      ),
                      style:
                      ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const IntakePage()) );
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child:
                    ElevatedButton(
                      child:
                        Container(
                          width: 100,
                          height: 100,
                        decoration: BoxDecoration(
                         image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/3352475.png'),
                             opacity: 0.25,
                         ),
                        ),
                          child:
                        Center(
                          child: Text(
                          'Sleep Journal',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0
                            ),
                          ),
                        ),
                      ),
                      style:
                      ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const JournalPage(title: 'Sleep Journal',)) );
                      },
                    ),
                    ),
                  ),


              ],
            ),

            ], // Children
          ),
      ),
      ),
    );
  }

}