
import 'package:flutter/material.dart';
import 'package:flutter_app/Data%20Structures/session.dart';
import 'package:flutter_app/Pages/StandCodePage.dart';
import 'package:flutter_app/QuizCreation/QuizManagementScreen.dart';
import 'package:flutter_app/UserInfo/screens.dart';
import 'package:flutter_app/UserMainScreen/UserMainScreen.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: Scaffold(
        appBar: AppBar(
          title: Text(user.username),
        ),
            body: Center(
                child: Column(children: <Widget>[
                  CreateQuizButton(),
                  AnswerQuizButton(),
                  ProfileDetailsButton()
                ])
      ),
      )
    );
  }
}


class CreateQuizButton extends StatelessWidget {
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
    // Nao funciona, nao sei porque
    //Navigator.pushNamed(context, page1.routeName);

    Navigator.push(context, new MaterialPageRoute(
        builder: (context) =>
        new QuizManagementScreen(quizzes: []))
    );
  }
}

class AnswerQuizButton extends StatelessWidget {
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
          text: "Answer Quiz",
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
        new StandCodePage())
    );
  }
}

class ProfileDetailsButton extends StatelessWidget {
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
          text: "Profile Details",
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
        new SecondScreen())
    );
  }
}
