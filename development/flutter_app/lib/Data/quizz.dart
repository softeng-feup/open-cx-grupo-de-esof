class Quiz{
  var currentQuestion;
  var questions = new List();

  Quiz(barcode){
    this.currentQuestion = 0;
  }

  Quiz.testCons(questions, correct){
    this.currentQuestion = 0;

    for(var i = 0; i < questions.length;i++) {
      var question = new Question(questions[i][0]);
      question.addAnswer(questions[i][1]);
      question.addAnswer(questions[i][2]);
      question.addAnswer(questions[i][3]);
      question.setCorrect(correct[i]);
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