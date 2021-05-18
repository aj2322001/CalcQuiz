import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:calc_quiz/custom_widgits/quiz.dart';
import 'package:calc_quiz/custom_widgits/result.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double fontSizeLabes;
  var _questionIndex = 0;
  var _correctAns = 0;
  var _wrongAns = 0;
  int ans;
  var _completedQues = 0;
  var _left;
  List<Map<String, Object>> _questions = [];
  int num1, num2, numQues, currentLev, subLev;
  Map levelData;
  IconData myIcon;
  List optionList;
  @override
  Widget build(BuildContext context) {
    levelData = ModalRoute.of(context).settings.arguments;
    currentLev = levelData['level'];
    subLev = levelData['subLev'];
    numQues = subLev * 5;
    fontSizeLabes = 35.0;
    _wrongAns = _questionIndex - _correctAns;
    _completedQues = _correctAns + _wrongAns;
    _left = numQues - _completedQues;
    myFun(_questions);
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.amber[700],
              Colors.amber[600],
              Colors.amber,
            ]),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.school,
                            size: 30.0,
                            color: Colors.grey[850],
                          ),
                          Row(
                            children: [
                              Text(
                                '$currentLev',
                                style: TextStyle(
                                  color: Colors.amber[50],
                                  letterSpacing: 2.0,
                                  fontSize: fontSizeLabes,
                                ),
                              ),
                              Text(
                                '$subLev',
                                style: TextStyle(
                                  color: Colors.amberAccent,
                                ),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        children: [
                          Container(
                            child: Text(
                              'Completed',
                              style: TextStyle(
                                color: Colors.amber[700],
                                // letterSpacing: 0.5,
                                fontSize: 20.0,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          Text(
                            '$_completedQues',
                            style: TextStyle(
                              color: Colors.amber[50],
                              letterSpacing: 2.0,
                              fontSize: fontSizeLabes,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Container(
                            child: Text(
                              'Left',
                              style: TextStyle(
                                color: Colors.amber[700],
                                fontSize: 20.0,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          Text(
                            '$_left',
                            style: TextStyle(
                              color: Colors.amber[50],
                              letterSpacing: 2.0,
                              fontSize: fontSizeLabes,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        children: [
                          Icon(CupertinoIcons.checkmark_seal_fill,
                              size: 30.0, color: Colors.grey[850]),
                          Text(
                            '$_correctAns',
                            style: TextStyle(
                              color: Colors.amber[50],
                              letterSpacing: 2.0,
                              fontSize: fontSizeLabes,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        children: [
                          Icon(CupertinoIcons.xmark_seal_fill,
                              size: 30.0, color: Colors.grey[850]),
                          Text(
                            '$_wrongAns',
                            style: TextStyle(
                              color: Colors.amber[50],
                              letterSpacing: 2.0,
                              fontSize: fontSizeLabes,
                            ),
                          ),
                        ],
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(20, 35, 20, 25),
                  //   child: LinearProgressIndicator(
                  //     value: _completedQues/numQues,
                  //     backgroundColor: Colors.transparent,
                  //     valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[700]),
                  //     minHeight: 0.5,
                  //   ),
                  // ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(50.0),
                      child: (_questionIndex < numQues)
                          ? Quiz(
                              _answerQuestion, _questions, _questionIndex, ans)
                          : Result(
                              _correctAns, numQues, resetQuiz, levelUpFunction),
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 30.0), //30
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: ((_correctAns + _left)/numQues < 0.85)
            ? FloatingActionButton(
                child: Icon(Icons.refresh,color: Colors.grey[350],),
                onPressed: resetQuiz,
                backgroundColor: Colors.amber[600],
              )
            : Container(),
      ),
    );
  }

  void _answerQuestion(int score) {
    _correctAns += score;
    setState(() {
      _questionIndex++;
    });
    print(_questionIndex);
    if (_questionIndex < numQues) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  void resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _correctAns = 0;
      _wrongAns = 0;
      _completedQues = 0;
      _questions.clear();
      _left = _questions.length - _completedQues;
    });
  }

  void levelUpFunction() {
    Navigator.pushReplacementNamed(context, '/profile', arguments: 1);
  }

  void options(int ans) {
    Random ranVar = new Random();
    optionList = [ans];
    int ranNum;
    int i = 0;
    while (i < 3) {
      ranNum = -11 + ranVar.nextInt(11 - (-11));
      if (optionList.contains(ans + ranNum)) {
        continue;
      }
      optionList.add(ans + ranNum);
      i++;
    }
  }

  int myScoreFun(int option, int answ) {
    if (option == answ) {
      return 1;
    } else {
      return 0;
    }
  }

  void myFun(List ques) {
    int min = currentLev * subLev;
    int max = currentLev * 20;
    List opList = ['+', '-', 'X', '÷'];
    Random random = new Random();

    num1 = min + random.nextInt(max - min);
    num2 = min + random.nextInt(max - min);
    // myIcon = opList[random.nextInt(opList.length)]['symbol'];

    String op = opList[random.nextInt(opList.length)];
    switch (op) {
      case '+':
        {
          ans = num1 + num2;
        }
        break;
      case '-':
        {
          if (currentLev < 5 && num2 > num1) {
            int temp = num1;
            num1 = num2;
            num2 = temp;
          }
          ans = num1 - num2;
        }
        break;
      case 'X':
        {
          ans = num1 * num2;
        }
        break;
      case '÷':
        {
          if (num2 > num1) {
            int temp = num1;
            num1 = num2;
            num2 = temp;
          }

          ans = num1 ~/ num2;
        }
        break;
    }
    options(ans);
    optionList.shuffle();
    ques.add(
      {
        'questionText': '$num1 $op $num2 = __',
        'answer': [
          {'text': '${optionList[0]}', 'score': myScoreFun(optionList[0], ans)},
          {'text': '${optionList[1]}', 'score': myScoreFun(optionList[1], ans)},
          {'text': '${optionList[2]}', 'score': myScoreFun(optionList[2], ans)},
          {'text': '${optionList[3]}', 'score': myScoreFun(optionList[3], ans)}
        ]
      },
    );
  }
}
