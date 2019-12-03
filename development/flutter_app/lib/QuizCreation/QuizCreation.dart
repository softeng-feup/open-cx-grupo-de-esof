

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/QuizCreation/QuizEdit.dart';


class TestQuizCard extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Stand Code',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Stand Code'),
          ),
          body: QuizEdit(),
        )
    );
  }


}