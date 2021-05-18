import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore, totalQues;
  double percentage;
  double passingMarks = 85;
  final Function resetHandler, levelUpFun;
  Result(this.resultScore,this.totalQues, this.resetHandler, this.levelUpFun);

  String get resultPhrase {
    percentage = (resultScore/totalQues)*100;
    String resultText = '${percentage.toStringAsFixed(2)}% \n';
    print('result: $percentage');
    if (percentage >= 95) {
      resultText += 'A+';
    } else if (percentage >= 90) {
      resultText += 'A';
    } else if (percentage >= 85) {
      resultText += 'B+';
    } else if (percentage >= 80) {
      resultText += 'B';
    } else if (percentage >= 75) {
      resultText += 'C+';
    } else if (percentage >= 70) {
      resultText += 'C';
    } else if (percentage >= 65) {
      resultText += 'D';
    } else {
      resultText += 'F';
    }
    resultText += '\n';
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
              wordSpacing: 2.0,
              letterSpacing: 2.0,
              color: percentage < passingMarks ? Colors.red[400]: Colors.green[400],
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: percentage < passingMarks ? ElevatedButton.icon(
              onPressed: resetHandler,
              icon: Icon(Icons.refresh, color: Colors.grey[700],size: 25.0,),
              label: Text(
                'Restart Quiz',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 20.0,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.fromLTRB(15, 15, 25, 15),
              ),
            ):ElevatedButton.icon(
              onPressed: levelUpFun,
              icon: Icon(Icons.arrow_right_rounded, color: Colors.grey[700],size: 50.0,),
              label: Text(
                'NextLevel',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 20.0,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                padding: EdgeInsets.fromLTRB(5, 15, 35, 15),
              ),
            ),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
