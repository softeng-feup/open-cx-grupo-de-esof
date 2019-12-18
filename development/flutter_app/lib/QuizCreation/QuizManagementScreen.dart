import 'dart:math';

import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/QuizCreation/QuizEditScreen.dart';
import 'package:flutter_app/QuizCreation/QuizInfo.dart';


class QuizManagementScreen extends StatefulWidget {

  final List<QuizInfo> quizzes;

  QuizManagementScreen({Key key, @required this.quizzes}) :
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _QuizManagementScreenState(this.quizzes);
  }


}

class _QuizManagementScreenState extends State<QuizManagementScreen> {

  QuizSelWindow quizSelWindow;

  _QuizManagementScreenState(List<QuizInfo> quizzes) :
        quizSelWindow = QuizSelWindow.fromList(quizInfoToInformationCards(quizzes)),  super();


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Extra Info'),
      ),
      body: Column(
        children: [

          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: quizSelWindow,
            ),
          ),

          Container(
            padding: EdgeInsets.all(10),
            height: 70,
            width: double.infinity,
            child: RaisedButton.icon(
              icon: Icon(Icons.send),
              label: Text('Submit'),
              onPressed: () {
                _sendDataBack(context);
              },
            ),
          ),

        ],
      ),
    );
  }

  List<QuizInfo> informationCardsToQuizInfo(List<QuizCard> list){

    List<QuizInfo> updatedQuizInfo = [];
    for (QuizCard card in list){
      updatedQuizInfo.add(card.quizInfo);
    }
    return updatedQuizInfo;
  }

  static List<QuizCard> quizInfoToInformationCards(List<QuizInfo> list){

    List<QuizCard> informationCards = [];
    for (QuizInfo quizInfo in list){
      informationCards.add(QuizCard(quizName: quizInfo.quizName));
    }
    return informationCards;
  }

  void _sendDataBack(BuildContext context) {
    List<QuizInfo> updatedExtraInfo = informationCardsToQuizInfo(quizSelWindow.getList());
    Navigator.pop(context, updatedExtraInfo);
  }
}

class QuizCard extends StatefulWidget {


  final QuizInfo quizInfo;
  final Color color;

  QuizCard({Key key, quizName = ''}) :
        color = Colors.blue,//primaries[Random().nextInt(Colors.primaries.length)],
        quizInfo = QuizInfo(quizName), super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _QuizCardState(quizInfo);
  }


}

//AutomaticKeepAlive used to stop List View from deleting information
class _QuizCardState extends State<QuizCard> with AutomaticKeepAliveClientMixin{

  TextEditingController infoController;
  QuizInfo quizInfo;
  FocusNode myFocusNode;

  _QuizCardState(QuizInfo extraInfo) : super(){
    this.quizInfo = extraInfo;
    this.infoController = TextEditingController(text: quizInfo.quizName);
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  void dispose() {
    myFocusNode.dispose();
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
      child: Row (
        children: <Widget>[
          Expanded(
            flex: 4,
            child: TextField(
              controller: infoController,
//              onChanged: _handleSubmission,
              onChanged: _updateInfo,
              decoration: InputDecoration(
                hintText: 'QuizName',
              ),
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: RaisedButton(
              color: Colors.lightBlueAccent,
              child: Icon(Icons.edit),


              onPressed: () {
                _awaitReturnValueFromExtraInfoScreen(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  _updateInfo(String text) {
    setState(() {
      quizInfo.quizName = text;
    });
  }

  void _awaitReturnValueFromExtraInfoScreen(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizEditScreen(quizInfo: this.quizInfo),
        ));

    // after the SecondScreen result comes back update the Text widget with it
  }

  @override
  bool get wantKeepAlive => true;

}

class QuizSelWindow extends StatefulWidget {

  final List<QuizCard> list;

  QuizSelWindow():
        this.list = [];

  QuizSelWindow.fromList(this.list);


  getList(){
    return this.list;
  }

  @override
  State<StatefulWidget> createState() {
    return _QuizSelWindowState();
  }
}

class _QuizSelWindowState extends State<QuizSelWindow> {

  @override
  Widget build(BuildContext context) {
    // TODO: make it prettier
    return Column(
        children: [
          RaisedButton(
            shape: CircleBorder(),
            child: Icon(Icons.add),
            onPressed: () {
              _update();
            },
          ),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) =>
                    Divider(
                      color: Colors.white,
                      thickness: 1,
                      height: 10,
                    ),
                addAutomaticKeepAlives: true,
                itemCount: widget.list.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = widget.list[index];
                  print(item.toString());
                  return Dismissible(
                    background: Container(color: Colors.red),
                    //TODO: USE BETTER KEY GENERATION
                    key: Key(prefix0.WordPair.random().asString + prefix0.WordPair.random().asString),
                    onDismissed: (direction) {
                      // Remove the item from the data source.
                      _removeCard(index);
                      // Then show a snackbar.
                      Scaffold.of(context)
                          .showSnackBar(
                          SnackBar(content: Text("$item removed")));
                    },
                    child: widget.list[index],
                  );
                }
            ),
          ),
        ]
    );
  }

  _update() {
    widget.list.insert(0, QuizCard());
    setState(() {});
  }

  _removeCard(index){
    setState(() {
      widget.list.removeAt(index);
    });
  }
}