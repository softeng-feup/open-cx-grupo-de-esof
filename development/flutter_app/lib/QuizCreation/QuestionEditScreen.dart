

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/QuizCreation/QuestionEdit.dart';

import '../Data Structures/QuestionInfo.dart';


class QuestionEditScreen extends StatelessWidget{

  final QuestionInfo questionInfo;

  QuestionEditScreen({Key key, @required this.questionInfo}): super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
          appBar: AppBar(
            title: Text('Question Edit'),
          ),
          body: QuestionEdit(questionInfo: this.questionInfo),
    );
  }


}