// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExtraInfo{

  String infoType = '';
  String info = '';

  ExtraInfo(this.infoType,  this.info);

  ExtraInfo.fromExtraInfo(ExtraInfo otherExtraInfo){
    this.infoType = otherExtraInfo.infoType;
    this.info = otherExtraInfo.info ;
  }
}

class ExtraInfoScreen extends StatefulWidget {

  final List<ExtraInfo> extraInfo;

  ExtraInfoScreen({Key key, this.extraInfo}) :
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ExtraInfoScreenState(this.extraInfo);
  }

  
}

class ExtraInfoScreenState extends State<ExtraInfoScreen> {

  DynamicInfoWindow dynamicInfoWindow;

  ExtraInfoScreenState(List<ExtraInfo> extraInfo) :
  dynamicInfoWindow = DynamicInfoWindow.fromList(extraInfoToInformationCards(extraInfo)), super();


  @override
  Widget build(BuildContext context) {



    Color color = Theme
        .of(context)
        .primaryColor;


    return Scaffold(
        appBar: AppBar(
          title: Text('Proj Esof'),
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              child: RaisedButton.icon(
                icon: Icon(Icons.send),
                label: Text('Submit'),
                onPressed: () {
                  _sendDataBack(context);
                },
              ),
            ),
            Expanded(
              child: dynamicInfoWindow,
            ),
          ],
        ),
      );
  }

  List<ExtraInfo> informationCardsToExtraInfo(List<InformationCard> list){

    List<ExtraInfo> updatedExtraInfo = [];
    for (InformationCard card in list){
      updatedExtraInfo.add(card.extraInfo);
    }
    return updatedExtraInfo;
  }

  static List<InformationCard> extraInfoToInformationCards(List<ExtraInfo> list){

    List<InformationCard> informationCards = [];
    for (ExtraInfo extraInfo in list){
      informationCards.add(InformationCard(info: extraInfo.info, infoName: extraInfo.infoType));
    }
    return informationCards;
  }

  void _sendDataBack(BuildContext context) {
    List<ExtraInfo> updatedExtraInfo = informationCardsToExtraInfo(dynamicInfoWindow.getList());
    Navigator.pop(context, updatedExtraInfo);
  }
}

class InformationCard extends StatefulWidget {


  final ExtraInfo extraInfo;

  InformationCard({Key key, infoName = '',  info = ''}) :
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

}

class DynamicInfoWindow extends StatefulWidget {

  final List<InformationCard> list;

  DynamicInfoWindow():
      this.list = [];

  DynamicInfoWindow.fromList(this.list);


  getList(){
    return this.list;
  }

  @override
  State<StatefulWidget> createState() {
    return _DynamicInfoWindowState();
  }
}

class _DynamicInfoWindowState extends State<DynamicInfoWindow> {

  @override
  Widget build(BuildContext context) {
    // TODO: make it prettier
    return Column(
        children: [
          RaisedButton(
            child: Text(
              'AddCard',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () {
              _update();
            },
          ),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) =>
                    Divider(
                      color: Colors.black,
                      thickness: 10,
                    ),
                addAutomaticKeepAlives: true,
                itemCount: widget.list.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = widget.list[index];
                  print(item.toString());
                  return Dismissible(
                    background: Container(color: Colors.red),
                    //TODO: USE BETTER KEY GENERATION
                    key: Key(prefix0.WordPair.random().asString),
                    onDismissed: (direction) {
                      // Remove the item from the data source.
                      _removeCard(index);
                      // Then show a snackbar.
                      Scaffold.of(context)
                          .showSnackBar(
                          SnackBar(content: Text("$item dismissed")));
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
    widget.list.add(InformationCard());
    setState(() {});
  }

  _removeCard(index){
    setState(() {
      widget.list.removeAt(index);
    });
  }
}


void main() {
  runApp(MaterialApp(
    title: 'Flutter',
    home: FirstScreen(),
  ));
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() {
    return _FirstScreenState();
  }
}

class _FirstScreenState extends State<FirstScreen> {

  String text = 'Text';
  String username = '';
  String email = '';
  String phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                username,
                style: TextStyle(fontSize: 24),
              ),
            ),

            RaisedButton(
              child: Text(
                'Go to second screen',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                _awaitReturnValueFromSecondScreen(context);
              },
            )

          ],
        ),
      ),
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(username: username, phoneNumber: phone, email: email,),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      username = result[0];
      email = result[1];
      phone = result[2];
    });
  }
}

class SecondScreen extends StatefulWidget {

  final String username;
  final String phoneNumber;
  final String email;
  SecondScreen({Key key, this.username, this.email, this.phoneNumber}) : super(key: key);

  @override
  _SecondScreenState createState() {
    return _SecondScreenState(this.username, this.phoneNumber, this.email);
  }
}

class _SecondScreenState extends State<SecondScreen> {
  // this allows us to access the TextField text

  String username;
  String phoneNumber;
  String email;
  List<ExtraInfo> extraInfo = [];

  _SecondScreenState(this.username, this.phoneNumber, this.email): super();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(this.username + this.phoneNumber + this.email)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          TextFieldWithSubmitButton(
            field: this.username,
            fieldType: 'Username',
            onChanged: _updateUsername,
          ),

          TextFieldWithSubmitButton(
            field: this.phoneNumber,
            fieldType: 'Phone Number',
            onChanged: _updatePhoneNumber,
            keyboardType: TextInputType.number,
          ),

          TextFieldWithSubmitButton(
            field: this.email,
            fieldType: 'E-mail',
            onChanged: _updateEmail,
          ),


          RaisedButton(
            child: Text(
              'Send text back',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () {
              _sendDataBack(context);
            },
          ),

          RaisedButton(
            child: Text(
              'Add Extra Info',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () {
              _awaitReturnValueFromExtraInfoScreen(context);
            },
          )

        ],
      ),
    );
  }

  // get the text in the TextField and send it back to the FirstScreen
  void _updateUsername(String username) {
    setState(() {
      this.username = username;
    });
  }

  void _updatePhoneNumber(String phone) {
    setState(() {
      this.phoneNumber = phone;
    });
  }

  void _updateEmail(String email) {
    setState(() {
      this.email = email;
    });
  }



  // get the text in the TextField and send it back to the FirstScreen
  void _sendDataBack(BuildContext context) {
    Navigator.pop(context, [this.username, this.email, this.phoneNumber]);
  }

  void _awaitReturnValueFromExtraInfoScreen(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExtraInfoScreen(extraInfo: this.extraInfo),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      this.extraInfo = result;
    });
  }


}

class TextFieldWithSubmitButton extends StatefulWidget {

  TextFieldWithSubmitButton({Key key, @required this.field, @required this.fieldType,  @required this.onChanged, this.keyboardType = TextInputType.text })
    : super(key: key);

  final TextInputType keyboardType; //currently not working. Switching between different keyboard types resets field
  final String field;
  final String fieldType;
  final ValueChanged<String> onChanged;

  @override
  _TextFieldWithSubmitButtonState createState() {
    return _TextFieldWithSubmitButtonState(this.field);
  }

}

class _TextFieldWithSubmitButtonState extends State<TextFieldWithSubmitButton> {

  String field;
  TextEditingController textFieldController;
  FocusNode myFocusNode;

  _TextFieldWithSubmitButtonState(this.field): super(){
    textFieldController = TextEditingController(text: this.field);
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: Fix Width
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              keyboardType: widget.keyboardType,
              controller: textFieldController,
//              onChanged: _handleSubmission,
              onSubmitted: _handleSubmission,
              decoration: InputDecoration(
                hintText: this.field,
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
                child: Text(
                  'Change ' + widget.fieldType,
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () {
                  _handleButtonSubmission();
                },
              )
          )
        ],
      ),
    );
  }

  void _handleButtonSubmission(){
    _handleSubmission(textFieldController.text);
  }

  void _handleSubmission(String text){

    setState(() {
      this.field = text;
    });
    widget.onChanged(this.field);
  }
}