
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWithSubmitButton extends StatefulWidget {

  TextFieldWithSubmitButton({Key key, @required this.field, @required this.fieldType, @required this.icon,
    @required this.onChanged, this.keyboardType = TextInputType.text}): super(key: key);

  final TextInputType keyboardType; //currently not working. Switching between different keyboard types resets field
  final String field;
  final String fieldType;
  final Icon icon;
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
                hintText: widget.fieldType,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 5.0),
                ),

              ),
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),


          Expanded(
              flex: 1,
            child: Container(
              padding: EdgeInsets.all(5),

              decoration: BoxDecoration(
              ),
              child: RaisedButton(
                shape: RoundedRectangleBorder(),
                color: Colors.blueAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Update', //+ widget.fieldType,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: widget.icon,
                    ),
                  ],
                ),
                onPressed: () {
                  _handleButtonSubmission();
                },
              ),
            ),
          ),
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
