

class QuestionInfo {

  String question;
  List<String> answers;
  List<bool> isCorrect;

  QuestionInfo(this.question);

  addAnswer(String answer, bool isCorrect){
    this.answers.add(answer);
    this.isCorrect.add(isCorrect);
  }
}