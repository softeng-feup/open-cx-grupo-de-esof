
import 'package:flutter/material.dart';
import 'package:flutter_app/Data%20Structures/session.dart';
import 'package:flutter_app/QuizCreation/QuizManagementScreen.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
      ),
      body: Center(
          child: Column(children: <Widget>[
            CreateQuizButton(),
          ])
      ),
    );
  }
}

class CreateQuizButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.lightBlue,
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
          text: "Create Quiz",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        textScaleFactor: 2,
      ),
    );
  }

  _buttonTap(BuildContext context) {
    Navigator.push(context, new MaterialPageRoute(
        builder: (context) =>
        new QuizManagementScreen(quizzes: []))
    );
  }
}


