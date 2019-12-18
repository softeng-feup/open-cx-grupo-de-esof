
import 'package:flutter/material.dart';
import 'package:flutter_app/QuizCreation/QuizManagementScreen.dart';
import 'package:flutter_app/UserMainScreen/UserMainScreen.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/";

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
                  ScanQR_button(),
                  CompanyButton()
                ])
      ),
      )
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
          text: "I'm a user",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        textScaleFactor: 2,
      ),
    );
  }

  _buttonTap(BuildContext context) {
    // Nao funciona, nao sei porque
    //Navigator.pushNamed(context, page1.routeName);

    Navigator.push(context, new MaterialPageRoute(
        builder: (context) =>
        new UserMainScreen())
    );
  }
}

class CompanyButton extends StatelessWidget {
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
          text: "I'm a Company",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        textScaleFactor: 2,
      ),
    );
  }

  _buttonTap(BuildContext context) {
    // Nao funciona, nao sei porque
    //Navigator.pushNamed(context, page1.routeName);

    Navigator.push(context, new MaterialPageRoute(
        builder: (context) =>
        new QuizManagementScreen(quizzes: []))
    );
  }
}