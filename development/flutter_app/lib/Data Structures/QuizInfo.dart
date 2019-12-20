import 'package:flutter_app/Data%20Structures/QuestionInfo.dart';

class QuizInfo {

  String quizName;
  List<QuestionInfo> questions = [];


  QuizInfo(this.quizName);

  clone(QuizInfo quizInfo){
    this.questions = quizInfo.questions;
    this.quizName = quizInfo.quizName;
  }

  addQuestion(QuestionInfo questionInfo){
    this.questions.add(questionInfo);
  }


}