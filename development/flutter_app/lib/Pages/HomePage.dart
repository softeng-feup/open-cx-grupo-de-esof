
import 'package:flutter/material.dart';
import 'package:flutter_app/UserMainScreen/UserMainScreen.dart';
import 'StandCodePage.dart';
import 'HomePage.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'QuizApp',
        home: Scaffold(
          appBar: AppBar(
            title: Text('QuizApp'),
          ),
          body: Center(
              child: Column(children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 40.0)),
                RichText(
                  text: TextSpan(
                    text: 'QuizApp',
                    style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.lightBlue
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 40.0)),
                  RichText(
                    text: TextSpan(
                      text: 'Login',
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.black,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Login_Form(),
                ),
                Padding(padding: EdgeInsets.only(top: 40.0)),
                Create_Account_Button()
              ])
          ),
        )
    );
  }
}


class Login_Form extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.values(List(5)),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
              text: 'Username',
              style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(padding: EdgeInsets.only(top: 40.0)),
          RichText(
            text: TextSpan(
              text: 'Password',
              style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // Process data.
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

}

class Create_Account_Button extends StatelessWidget {
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
          text: "Don't have an account?",
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