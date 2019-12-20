import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Data%20Structures/AnswerQuiz.dart';

class StartQuiz extends StatefulWidget{
  final Quiz quiz;

  const StartQuiz({Key key, this.quiz}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _StartQuizState();

}

class _StartQuizState extends State<StartQuiz> {
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Start Quiz"),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new RaisedButton(
                child: new Text("Start"),
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new AnswerQuestion(quiz: widget.quiz)));
                }
            ),
          )
        ],
      ),
    );
  }
}



class AnswerQuestion extends StatefulWidget{
  final Quiz quiz;

  const AnswerQuestion({Key key, this.quiz}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _AnswerQuestionState();

}

class _AnswerQuestionState extends State<AnswerQuestion> {

  @override
  Widget build(BuildContext context){
    var answers = widget.quiz.getQuestion().getAnswers();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Start Quiz"),
      ),
      body: new Column(
          children: <Widget>[
            new Text(
              "${widget.quiz.getQuestion().getQuestion()}",
              style: new TextStyle(
                fontSize: 40.0,
              ),
            ),
            for (var answer in answers)
              // ignore: sdk_version_ui_as_code, sdk_version_ui_as_code
              Center(
                child: new RaisedButton(
                    child: new Text(answer,
                      style: new TextStyle(
                        fontSize: 40.0,
                      ),
                    ),
                    onPressed: () {
                      if (widget.quiz.getQuestion().isCorrect(answer)) {
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (context) =>
                            new RightAnswer(quiz: widget.quiz)));
                      }
                      else {
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (context) =>
                            new WrongAnswer(quiz: widget.quiz)));
                      }
                    }
                ),
              )
          ]
      ),
    );
  }
}

class RightAnswer extends StatefulWidget{
  final Quiz quiz;

  const RightAnswer({Key key, this.quiz}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _RightAnswerState();

}

class _RightAnswerState extends State<RightAnswer> {
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Answer"),
      ),
      body: new Column(
          children: <Widget>[
            new Text(
              "Correct",
              style: new TextStyle(
                fontSize: 40.0,
              ),
            ),
            new RaisedButton(
                child: new Text("Next",
                  style: new TextStyle(
                    fontSize: 40.0,
                  ),
                ),
                onPressed: () {
                  if (widget.quiz.nextQuestion()){
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new AnswerQuestion(quiz: widget.quiz)));

                  }
                }
            ),
          ]
      ),
    );
  }
}

class WrongAnswer extends StatefulWidget{
  final Quiz quiz;

  const WrongAnswer({Key key, this.quiz}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _WrongAnswerState();

}

class _WrongAnswerState extends State<WrongAnswer> {
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Answer"),
      ),
      body: new Column(
          children: <Widget>[
            new Text(
              "Wrong",
              style: new TextStyle(
                fontSize: 40.0,
              ),
            ),
            new Text(
              "Correct answer:",
              style: new TextStyle(
                fontSize: 40.0,
              ),
            ),
            new Text(
              "${widget.quiz.getQuestion().getCorrectAnswer()}",
              style: new TextStyle(
                fontSize: 40.0,
              ),
            ),
            new RaisedButton(
                child: new Text("Next",
                  style: new TextStyle(
                    fontSize: 40.0,
                  ),
                ),
                onPressed: () {
                  if (widget.quiz.nextQuestion()){
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new AnswerQuestion(quiz: widget.quiz)));

                  }
                }
            ),
          ]
      ),
    );
  }
}