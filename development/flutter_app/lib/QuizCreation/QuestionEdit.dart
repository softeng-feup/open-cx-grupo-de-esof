
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'QuestionInfo.dart';

class QuestionEdit extends StatefulWidget {

  final QuestionInfo questionInfo;

  QuestionEdit({Key key, @required this.questionInfo}): super(key: key);


  @override
  State<QuestionEdit> createState() {
    return new _QuestionEditState(questionInfo: questionInfo);
  }
}

class _QuestionEditState extends State<QuestionEdit> {


  QuestionInfo questionInfo;

  TextEditingController controller;

  AnswerList answerList;
  int correctAnswer = 0;



  _QuestionEditState({this.questionInfo}): super() {
    controller = TextEditingController(text: this.questionInfo.question);
    answerList = AnswerList(questionInfo: questionInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(
                    width: 5,
                    color: Colors.black,
                  )
              ),
              child: Center(
                  child: TextField(
                    maxLines: null,
                    controller: controller,
                    onChanged: _updateQuestion,
                    decoration: InputDecoration(
                      hintText: 'Insert Question',
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textInputAction: TextInputAction.send,
                  )
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: answerList,
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

          Container(
            height: 10,
          ),

        ],
      ),
    );
  }

  _updateQuestion(String value){
    setState(() {
      this.questionInfo.question = value;
    });
  }

  QuestionInfo _getQuestionInfo(){
    return this.questionInfo;
  }

  void _sendDataBack(BuildContext context) {
    Navigator.pop(context, _getQuestionInfo());
  }
}

class AnswerList extends StatefulWidget{

  final QuestionInfo questionInfo;

  AnswerList({Key key, @required this.questionInfo}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AnswerListState(this.questionInfo);
  }
}

class _AnswerListState extends State<AnswerList> {

  int _radioValue1;

  _AnswerListState(QuestionInfo questionInfo):super(){
    _radioValue1 = questionInfo.correctAnswer - 1;
  }

  @override
  Widget build(BuildContext context) {

    List<String> answers = widget.questionInfo.answers;
    return Column(
        children: [
          Expanded(flex: 32,
            child: ReorderableListView(
              children: List.generate(answers.length, (index) {
                int count = index + 1;
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
                    child: Row(children:
                    [
                      Container(
                        width: 100.0,
                        height: double.infinity,
                        color: Colors.black,
                        child: Radio(
                          value: index,
                          groupValue: _radioValue1,
                          onChanged: _handleRadioValueChange1,
                          activeColor: Colors.green,
                        ),
                      ),

                      Container(
                        width: 285,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(height: 20, child: Text("Answer nº $count\n" ),),
                            Container(
                              height: 80, child: EditableAnswer(
                                initialAnswer: answers[index],
                                onChanged: (String newAnswer) =>
                                    _updateAnswer(newAnswer, index)),
                            ),

                          ],
                        ),
                      ),
                    ]
                    ),
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

          Expanded(
            flex: 4,
            child: RaisedButton(
              shape: CircleBorder(),
              child: Icon(Icons.add),
              onPressed: () {
                _addAnswer();
              },
            ),
          ),

          Expanded(
            flex: 1,
            child: Container(child: Center( child: Container(),)),
          )
        ]
    );
  }

  _updateQuestion(oldIndex, newIndex) {

    List<String> answers = widget.questionInfo.answers;

    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final String answer = answers.removeAt(oldIndex);
    answers.insert(newIndex, answer);

    bool radioValueChangedPosition = ((_radioValue1 - oldIndex) *
        (_radioValue1 - newIndex)) <= 0;
    if (oldIndex == _radioValue1)
      _handleRadioValueChange1(newIndex);
    else if (radioValueChangedPosition) {
      if (oldIndex < _radioValue1)
        _handleRadioValueChange1(_radioValue1 - 1);
      else
        _handleRadioValueChange1(_radioValue1 + 1);
    }
  }

  _addAnswer() {
    List<String> answers = widget.questionInfo.answers;
    if (answers.length == 4) {
      Scaffold.of(context)
          .showSnackBar(
          SnackBar(content: Text("Max. 4 answers")));
      return;
    }
    setState(() {
      answers.add('');
    });
  }

  _updateAnswer(String string, int index) {
    List<String> answers = widget.questionInfo.answers;
    answers.removeAt(index);
    answers.insert(index, string);
  }

  _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
    widget.questionInfo.correctAnswer = _radioValue1 + 1;
  }
}

class EditableAnswer extends StatefulWidget{

  final ValueChanged<String> onChanged;
  final String initialAnswer;

  EditableAnswer({Key key, @required this.onChanged, this.initialAnswer = ''}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditableAnswerState(this.initialAnswer);
  }
}

class _EditableAnswerState extends State<EditableAnswer>{


  TextEditingController controller;
  String currAnswer;
  FocusNode myFocusNode;

  _EditableAnswerState(this.currAnswer): super() {
    controller = TextEditingController(text: this.currAnswer);
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      controller: controller,
      onChanged: _updateName,
      decoration: InputDecoration(
        hintText: 'Insert Answer',
      ),
      style: TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
      textInputAction: TextInputAction.send,
    );
  }

  void _updateName(String value){
    setState(() {
      this.currAnswer = value;
    });
    widget.onChanged(value);
  }

}