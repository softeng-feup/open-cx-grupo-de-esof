

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

  List<QuestionInfo> quiz = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('User Info')),
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
                child: ReorderableListView(
                  children: List.generate(quiz.length, (index) {
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
                        child: QuestionCard(questionInfo: quiz[index]),
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
            ]

        ),
      );
  }

  _updateQuestion(oldIndex, newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final QuestionInfo answer = quiz.removeAt(oldIndex);
    quiz.insert(newIndex, answer);
  }

  _addQuestion() {
    setState(() {
      quiz.add(QuestionInfo('New Question'));
    });
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

    this.questionInfo.clone(result);
  }
}