

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/QuizCreation/QuizInfo.dart';

import 'QuestionEditScreen.dart';
import 'QuestionInfo.dart';

class QuizEditScreen extends StatefulWidget {

  final QuizInfo quizInfo;

  QuizEditScreen({Key key, @required this.quizInfo}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _QuizEditScreenState(quiz: quizInfo );
  }

}

class _QuizEditScreenState extends State<QuizEditScreen> {

  QuizInfo quiz;

  _QuizEditScreenState({@required this.quiz}): super();


  @override
  Widget build(BuildContext context) {

    List<QuestionInfo> questions = quiz.questions;
    return Scaffold(
        appBar: AppBar(title: Text(quiz.quizName)),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Expanded(
                flex: 2,
                child: RaisedButton(
                  shape: CircleBorder(),
                  child: Icon(Icons.add),
                  onPressed: () {
                    _addQuestion();
                  },
                ),
              ),


              Expanded(flex: 16,
                child: Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: ReorderableListView(
                    children: List.generate(questions.length, (index) {
                      return Container(
                        padding: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          right: 10,
                          left: 10,
                        ),
                        height: 150,
                        //padding: EdgeInsets.all(5),
                        key: ValueKey("value$index"),
                        child: Container(

                          decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(
                              color: Colors.black,
                              width: 3,
                            ),
                          ),
                          child: QuestionCard(questionInfo: questions[index]),
                        ),

                      );
                    }),

                    onReorder: (int oldIndex, int newIndex) {
                      setState(() {
                        _updateQuestion(oldIndex, newIndex);
                      });
                    },
                  ),
                ),
              ),

              Container(
                height: 50,
                child: RaisedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    _sendDataBack(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),

                      Expanded(
                        child: Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ),
            ]

        ),
      );
  }

  _updateQuestion(oldIndex, newIndex) {
    List<QuestionInfo> questions = quiz.questions;
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final QuestionInfo answer = questions.removeAt(oldIndex);
    questions.insert(newIndex, answer);
  }

  _addQuestion() {
    setState(() {
      quiz.addQuestion(QuestionInfo('New Question'));
    });
  }

  //TODO: IMPLEMENT SEND DATA BACK
  void _sendDataBack(BuildContext context) {
    Navigator.pop(context, this.quiz);
  }

}


class QuestionCard extends StatelessWidget{

  final QuestionInfo questionInfo;

  QuestionCard({Key key, @required this.questionInfo}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.black,
        )
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                questionInfo.question,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.lightBlue,
                width: 2,
              ),
            ),
            height: 55,
            width: 55,
            child: RaisedButton(
              color: Colors.lightBlueAccent,
              child: Icon(Icons.edit),

              onPressed: () {
                _awaitReturnValueFromQuestionInfoScreen(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _awaitReturnValueFromQuestionInfoScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final QuestionInfo result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              QuestionEditScreen(questionInfo: this.questionInfo),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    /*setState(() {
      if (result != null)
        this.questionInfo = result;
    });*/

    //this.questionInfo.clone(result);
  }
}