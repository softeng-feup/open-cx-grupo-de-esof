
import 'package:flutter/material.dart';
import '../app.dart';
import 'homePage.dart';

class HomePage2 extends StatelessWidget {
//  @override
////  Widget build(BuildContext context) {
////    return Scaffold(
////      appBar: AppBar(
////        title: Text('HomePage 2'),
////      ),
////      body: Text(' '),
////    );
////  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage2',
      home: Scaffold(
        appBar: AppBar(
          title: Text('HomePage 2'),
        ),
        body: Center(
          child: MyButton(),
        ),
      ),
    );
  }
}