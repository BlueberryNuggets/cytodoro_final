import 'package:flutter/material.dart';

class MyStartScreen extends StatelessWidget {
  const MyStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[300],
          title: Text('Start Screen'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              //navigate to homescreen 
              Navigator.pushNamed(context, '/homescreen');
            },
            child: Text('Go to Home Screen'),
          ),
        ));
  }
}
