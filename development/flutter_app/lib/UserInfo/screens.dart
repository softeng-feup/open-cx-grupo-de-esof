import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'ExtraInfo.dart';
import 'TextFieldWithSubmitButton.dart';



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


    return Scaffold(
      appBar: AppBar(
        title: Text('Extra Info'),
      ),
      body: Column(
        children: [

          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: dynamicInfoWindow,
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
    widget.list.insert(0, InformationCard());
    setState(() {});
  }

  _removeCard(index){
    setState(() {
      widget.list.removeAt(index);
    });
  }
}

class SecondScreen extends StatefulWidget {

  final String username;
  final String phoneNumber;
  final String email;
  final List<ExtraInfo> extraInfo;
  SecondScreen({Key key, this.username, this.email, this.phoneNumber, this.extraInfo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SecondScreenState(this.username, this.phoneNumber, this.email, this.extraInfo);
  }
}

class _SecondScreenState extends State<SecondScreen> {
  // this allows us to access the TextField text

  String username;
  String phoneNumber;
  String email;
  List<ExtraInfo> extraInfo;

  _SecondScreenState(this.username, this.phoneNumber, this.email, this.extraInfo): super();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('User Info')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          TextFieldWithSubmitButton(
            field: this.username,
            fieldType: 'Username',
            icon: Icon(Icons.person),
            onChanged: _updateUsername,
          ),

          TextFieldWithSubmitButton(
            field: this.phoneNumber,
            fieldType: 'Phone Number',
            icon: Icon(Icons.phone),
            onChanged: _updatePhoneNumber,
            keyboardType: TextInputType.number,
          ),

          TextFieldWithSubmitButton(
            field: this.email,
            fieldType: 'E-mail',
            icon: Icon(Icons.email),
            onChanged: _updateEmail,
          ),


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
                    child: Text(
                      'Manage Extra Information',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),

                  Expanded(
                    child: Icon(Icons.more),
                  ),
                ],
              ),

              onPressed: () {
                _awaitReturnValueFromExtraInfoScreen(context);
              },
            ),
          ),

        ]

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
    Navigator.pop(context, [this.username, this.email, this.phoneNumber, this.extraInfo ]);
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
      if (result != null)
        this.extraInfo = result;
    });
  }


}