

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'QuestionEditScreen.dart';
import 'QuestionInfo.dart';

class QuizEditScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QuizEditScreenState();
  }

}

class _QuizEditScreenState extends State<QuizEditScreen> {

  QuestionInfo questionInfo = QuestionInfo("Ola?");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('User Info')),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.lightBlue,
                    width: 2,
                  ),
                ),
                height: 55,
                child: RaisedButton(
                  color: Colors.lightBlueAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          questionInfo.question,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: Icon(Icons.more),
                      ),
                    ],
                  ),

                  onPressed: () {
                    _awaitReturnValueFromQuestionInfoScreen(context);
                  },
                ),
              ),

            ]

        ),
      );
  }


  void _awaitReturnValueFromQuestionInfoScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              QuestionEditScreen(questionInfo: this.questionInfo),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      if (result != null)
        this.questionInfo = result;
    });
  }

}