import 'package:flutter/material.dart';

import 'screen/classscreen.dart';
import 'screen/formationscreen.dart';
import 'screen/login.dart';
import 'screen/studentsscreen.dart';

// 10.0.2.2
// 10.0.2.2
// localhost
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: {
        '/login': (context) => Login(),
        '/students': (context) => StudentScreen(),
        '/class': (context) => ClasseScreen(),
        '/formation': (context) => FormationScreen()
      },
    );
  }
}
