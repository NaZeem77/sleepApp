import 'package:flutter/material.dart';
import '../dreams/views/dreams_component.dart';
import '../dreams/presenter/dreams_presenter.dart';

//All sleep calculator code was implemented by UMD Duluth Teacher Assistant Joseph Hnatek.

class CalcPage extends StatefulWidget {
  const CalcPage({super.key});

  @override
  State<CalcPage> createState() => CalcPageState();
} //MyHomePage

class CalcPageState extends State<CalcPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),

    body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text("Sleep Calculator",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent), textScaleFactor: 3,)
              ,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent
              ),
              child: Text('Begin'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return SplashScreen();
                }));
              },
            )
          ],
        )
    ),
    );
  }

}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new HomePage(new BasicPresenter(), title: 'Sweet Dreams', key: Key("UNITS"),);
  }
}
