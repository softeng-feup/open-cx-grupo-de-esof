
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
              child: Center(
                child: Text(
                    this.question,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,

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
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.lightBlue,
                      width: 2,
                    ),
                  ),
                  height: 100,
                  padding: EdgeInsets.all(2),
                  key: ValueKey("value$index"),
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

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(flex: 1, child: Text("Answer nº $index\n"),),
                        Expanded(flex: 5, child: Text(answers[index]),),

                      ],
                    ),
                  ]
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
            child: Container(),
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

  _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
  }
}
/*
class InformationCard extends StatefulWidget {


  final ExtraInfo extraInfo;
  final Color color;

  InformationCard({Key key, infoName = '',  info = ''}) :
        color = Colors.primaries[Random().nextInt(Colors.primaries.length)],
        extraInfo = ExtraInfo(infoName, info), super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _InformationCardState(extraInfo);
  }


}

//AutomaticKeepAlive used to stop List View from deleting information
class _InformationCardState extends State<InformationCard> with AutomaticKeepAliveClientMixin{

  TextEditingController infoNameController;
  TextEditingController infoController;
  ExtraInfo extraInfo;
  FocusNode myFocusNode1;
  FocusNode myFocusNode2;

  _InformationCardState(ExtraInfo extraInfo) : super(){
    this.extraInfo = extraInfo;
    infoNameController = TextEditingController(text: extraInfo.infoType);
    infoController = TextEditingController(text: extraInfo.info);
  }

  @override
  void initState() {
    super.initState();
    myFocusNode1 = FocusNode();
    myFocusNode2 = FocusNode();
  }

  void dispose() {
    myFocusNode1.dispose();
    myFocusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: make it prettier
    super.build(context);
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: infoNameController,
//              onChanged: _handleSubmission,
            onChanged: _updateName,
            decoration: InputDecoration(
              hintText: 'Contact Type',
            ),
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),


          TextField(
            controller: infoController,
//              onChanged: _handleSubmission,
            onChanged: _updateInfo,
            decoration: InputDecoration(
              hintText: 'Contact',
            ),
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  _updateInfo(String text) {
    setState(() {
      extraInfo.info = text;
    });
  }

  _updateName(String text) {
    setState(() {
      extraInfo.infoType = text;
    });
  }

  @override
  bool get wantKeepAlive => true;

}*/
