import 'package:flutter_app/Data%20Structures/QuizInfo.dart';

import 'AnswerQuiz.dart';
import 'User.dart';

var user = new User();
List<QuizInfo> quizzes = [];
List<Quiz> answers = [];

searchName(name) {
  for(var i = 0; i < quizzes.length; i++) {
    if (quizzes[i].quizName == name){
      return true;
    }
  }
  return false;
}

getQuiz(name) {
  var quiz;
  for(var i = 0; i < quizzes.length; i++) {
    if (quizzes[i].quizName == name) {
      print(quizzes[i].questions[0].question);
      quiz = quizzes[i];
    }
  }

  var answer = new Quiz(quiz);
  answers.add(answer);
  return answer;
}