
import 'package:flutter/material.dart';
import 'Pages/LoginPage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',

      routes: {
        '/': (context) => LoginPage(),
      }
    );
  }

}