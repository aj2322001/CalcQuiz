import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;
  final int score,corrAns;
  Answer(this.selectHandler, this.answerText, this.score,this.corrAns);
  @override
  Widget build(BuildContext context) {
    print(corrAns);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text(
              answerText,
              style: TextStyle(
                color: Colors.grey[700],
                letterSpacing: 1.0,
                wordSpacing: 2.0,
                fontSize: 20.0,
              ),
            ),
          ),
          onPressed: selectHandler,
          style: ElevatedButton.styleFrom(
            primary: Colors.amber,
            onPrimary: (int.parse(answerText)==corrAns) ? Colors.greenAccent[700]: Colors.redAccent[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            shadowColor: Colors.amberAccent,
          ),
        ),
      ),
      width: double.infinity,
    );
  }
}
