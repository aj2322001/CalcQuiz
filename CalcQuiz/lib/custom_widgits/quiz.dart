import 'package:flutter/material.dart';
import 'question.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  final int questionIndex;
  int ans;
  final List<Map<String, Object>> questions;
  final Function answerQuestion;
  Quiz(this.answerQuestion, this.questions, this.questionIndex, this.ans);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[questionIndex]['questionText']),
        ...(questions[questionIndex]['answer'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => {answerQuestion(answer['score'])}, answer['text'], answer['score'],ans);
        }).toList()
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}