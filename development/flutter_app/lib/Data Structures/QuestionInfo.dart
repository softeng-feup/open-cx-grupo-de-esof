

class QuestionInfo {

  String question;
  List<String> answers = [];
  int correctAnswer = 1;

  QuestionInfo(this.question);

  clone(QuestionInfo questionInfo){
    this.question = questionInfo.question;
    this.answers = questionInfo.answers;
    this.correctAnswer = questionInfo.correctAnswer;
  }

  addAnswer(String answer){
    this.answers.add(answer);
  }


}