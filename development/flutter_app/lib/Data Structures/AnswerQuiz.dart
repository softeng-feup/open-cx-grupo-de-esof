
import 'QuizInfo.dart';

class Quiz{
  var currentQuestion;
  var questions = new List();

  Quiz(QuizInfo quizInfo){
    this.currentQuestion = 0;

    for(var i = 0; i < quizInfo.questions.length;i++) {
      var question = new Question(quizInfo.questions[i].question);
      for(var j = 0; j < quizInfo.questions[i].answers.length;j++) {
        question.addAnswer(quizInfo.questions[i].answers[j]);
      }
      question.setCorrect(quizInfo.questions[i].correctAnswer - 1);
      this.questions.add(question);
    }
  }

  getQuestion() {
    return this.questions[this.currentQuestion];
  }

  nextQuestion() {
    this.currentQuestion++;
    if (currentQuestion >= this.questions.length)
      return false;
    else
      return true;
  }
}

class Question{
  var question;
  var answers = new List();
  var correctAnswer;

  Question(question){
    this.question = question;
  }

  addAnswer(answer){
    this.answers.add(answer);
  }

  setCorrect(correct){
    if (correct < 0)
      this.correctAnswer = 0;
    else if (correct >= this.answers.length){
      this.correctAnswer = this.answers.length - 1;
    }
    else
      this.correctAnswer = correct;
  }

  getQuestion(){
    return this.question;
  }

  getAnswers(){
    return this.answers;
  }
  getCorrectAnswer(){
    return this.answers[this.correctAnswer];
  }

  isCorrect(answer){
    if (answer == this.answers[this.correctAnswer])
      return true;
    else
      return false;
  }

}