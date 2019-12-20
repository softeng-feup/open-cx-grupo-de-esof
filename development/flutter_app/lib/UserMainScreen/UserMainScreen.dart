

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/StandCodePage.dart';
import 'package:flutter_app/Data%20Structures/ExtraInfo.dart';
import 'package:flutter_app/UserInfo/screens.dart';


class UserMainScreen extends StatefulWidget {
  @override
  _UserMainScreenState createState() {
    return _UserMainScreenState();
  }
}

class _UserMainScreenState extends State<UserMainScreen> {

  String username = '';
  String email = '';
  String phone = '';
  List<ExtraInfo> extraInfo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                username,
                style: TextStyle(fontSize: 24),
              ),
            ),

            RaisedButton(
              child: Text(
                'QR stuff',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                _buttonQRTap(context);
              },
            ),
            
            RaisedButton(
              child: Text(
                'Go to second screen',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                _awaitReturnValueFromSecondScreen(context);
              },
            )

          ],
        ),
      ),
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      username = result[0];
      email = result[1];
      phone = result[2];
      extraInfo = result[3];
    });
  }

  void _buttonQRTap(BuildContext context) {
    // Nao funciona, nao sei porque
    //Navigator.pushNamed(context, page1.routeName);

    Navigator.push(context, new MaterialPageRoute(
        builder: (context) =>
        new StandCodePage())
    );
  }
}