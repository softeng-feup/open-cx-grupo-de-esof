
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizEdit extends StatefulWidget {



  @override
  State<QuizEdit> createState() {
    return new _QuizEdit(question: 'Ya like Jaaaazzzz? The quantic dream tells you where the sweet, luscious jazz is :)');
  }
}

class _QuizEdit extends State<QuizEdit> {


  String question;



  _QuizEdit({this.question = 'Novo Quiz'});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(
                    width: 5,
                    color: Colors.black,
                  )
              ),
              child: Center(
                child: Text(
                    this.question,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,

                    )
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: AnswerList(),
          ),
        ],
      ),
    );
  }
  

}

class AnswerList extends StatefulWidget{

  final List<String> answers = [];

  @override
  State<StatefulWidget> createState() {
    return _AnswerListState(answers: this.answers);
  }

}

class _AnswerListState extends State<AnswerList> {

  int _radioValue1 = 0;
  List<String> answers;

  _AnswerListState({@required this.answers});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(flex: 16,
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
                  height: 100,
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
                            Expanded(flex: 1, child: Text("Answer nº $count\n" ),),
                            Container(
                              height: 40, child: EditableAnswer(
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
                  _updateQuiz(oldIndex, newIndex);
                });
              },
            ),
          ),

          Expanded(
            flex: 2,
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

  _updateQuiz(oldIndex, newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final String answer = answers.removeAt(oldIndex);
    answers.insert(newIndex, answer);

    bool radioValueChangedPosition = ((_radioValue1 - oldIndex) *
        (_radioValue1 - newIndex)) <= 0;
    if (oldIndex == _radioValue1)
      _radioValue1 = newIndex;
    else if (radioValueChangedPosition) {
      if (oldIndex < _radioValue1)
        _radioValue1--;
      else
        _radioValue1++;
    }
  }

  _addAnswer() {
    if (answers.length == 4) {
      Scaffold.of(context)
          .showSnackBar(
          SnackBar(content: Text("Max. 4 answers")));
      return;
    }
    setState(() {
      answers.add('Broas i Q ta tudo, ya? ' + answers.length.toString());
    });
  }

  _updateAnswer(String string, int index){
      answers.removeAt(index);
      answers.insert(index, string);
  }

  _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
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
      controller: controller,
      onChanged: _updateName,
      decoration: InputDecoration(
        hintText: 'Insert Answer',
      ),
      style: TextStyle(
        fontSize: 24,
        color: Colors.black,
      ),
    );
  }

  void _updateName(String value){
    setState(() {
      this.currAnswer = value;
    });
    widget.onChanged(value);
  }

}