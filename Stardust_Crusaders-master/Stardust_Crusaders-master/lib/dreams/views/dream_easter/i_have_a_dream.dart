import 'package:flutter/material.dart';


class EasterPage extends StatefulWidget {
  const EasterPage({super.key});

  @override
  State<EasterPage> createState() => EasterPageState();
} //MyHomePage

class EasterPageState extends State<EasterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Varanara'),
        ),
    body:
       Wrap(
         spacing: 50,
        children: [
          Center(
            child: Container(
              width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/Arabalika_(YS-MU).png'),
                    ),
                  )
              ),
          ),
            Center(
              child: Container(
                  width: 450,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/341101777_662719335863208_7904842234199510309_n.jpg'),
                    ),
                  )
              ),
            ),


        ],
      ),

      );

  }
}