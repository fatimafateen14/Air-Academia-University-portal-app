import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Classroom API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GoogleClassroomPage(),
    );
  }
}

class GoogleClassroomPage extends StatelessWidget {
  final String classroomUrl = 'https://classroom.google.com/';

  Future<void> _navigateToClassroom() async {
    if (await canLaunch(classroomUrl)) {
      await launch(classroomUrl);
    } else {
      throw 'Could not launch $classroomUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Classroom API Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _navigateToClassroom,
          child: Text('Open Google Classroom'),
        ),
      ),
    );
  }
}
