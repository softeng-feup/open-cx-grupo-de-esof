import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'Page1.dart';
import '../app.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: Center(
            child: Column(children: <Widget>[
              SizedBox(height: 10),
              Title(),
              SizedBox(height: 10),
              StandCodeTextField(),
              SizedBox(height: 50),
              AdviceText(),
              SizedBox(height: 50),
              ScanQR_button(),
            ])
      ),
    )
    );
  }
}

class AdviceText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.white,
      textColor: Colors.black,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      padding: EdgeInsets.all(8.0),
      splashColor: Colors.blue,
      onPressed: () {

      },
      child: RichText(
        text: TextSpan(
          text: 'You can also access the quizzes via a QR Code',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        textScaleFactor: 1.5,
      ),
    );
  }
}

class StandCodeTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Insert here the stand code',
      ),
    );
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.white,
      textColor: Colors.black,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      padding: EdgeInsets.all(8.0),
      splashColor: Colors.blue,
      onPressed: () {

      },
      child: RichText(
        text: TextSpan(
          text: 'Stand Code',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        textScaleFactor: 2.5,
      ),
    );
  }
}

class ScanQR_button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.black,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      padding: EdgeInsets.all(8.0),
      splashColor: Colors.blue,
      onPressed: () {
        _buttonTap(context);
      },
      child: RichText(
        text: TextSpan(
          text: 'Scan QR Code',
          style: TextStyle(
            color: Colors.white,
              ),
        ),
        textScaleFactor: 2,
      ),
    );
  }

  _buttonTap(BuildContext context) {
    print("tapped!");

    // Nao funciona, nao sei porque
    //Navigator.pushNamed(context, page1.routeName);

    Navigator.push(context, new MaterialPageRoute(
        builder: (context) =>
        new Page1())
    );
  }
}