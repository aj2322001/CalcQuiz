import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';

class InPage extends StatefulWidget {
  static const double cardVerticalLen = 20.0;
  static const double cardHorizontalLen = 5.0;
  @override
  _InPageState createState() => _InPageState();
}

class _InPageState extends State<InPage> {
  Color symbolsColors = Colors.white70;

  Color textColor = Colors.grey[300];

  Color cardColor = Colors.orange;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('CalcQuiz'),
          centerTitle: true,
          backgroundColor: Colors.amber,
          // backgroundColor: Colors.orange,
        ),
        body: Center(
          // padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                'enter number of question',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  wordSpacing: 2.0,
                  decoration: TextDecoration.underline,
                  decorationThickness: 2.0,
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: (){},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: InPage.cardVerticalLen,
                              horizontal: InPage.cardHorizontalLen),
                          child: Column(
                            children: [
                              Icon(
                                CupertinoIcons.add,
                                size: 150.0,
                                // color: symbolsColors,
                              ),
                              Text(
                                'Addition',
                                style: TextStyle(
                                    fontSize: 30.0,
                                    // color: textColor,
                                    letterSpacing: 2.0),
                              )
                            ],
                          ),
                        ),
                        // color: cardColor,
                        // elevation: 10.0,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          elevation: 15.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: (){},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: InPage.cardVerticalLen,
                              horizontal: InPage.cardHorizontalLen),
                          child: Column(
                            children: [
                              Icon(
                                CupertinoIcons.minus,
                                size: 150.0,
                                // color: symbolsColors,
                              ),
                              Text(
                                'Subtraction',
                                style: TextStyle(
                                    fontSize: 30.0,
                                    // color: textColor,
                                    letterSpacing: 1.0),
                              )
                            ],
                          ),
                        ),
                        // color: cardColor,
                        // elevation: 10.0,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          elevation: 15.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: (){},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: InPage.cardVerticalLen,
                              horizontal: InPage.cardHorizontalLen),
                          child: Column(
                            children: [
                              Icon(
                                CupertinoIcons.multiply,
                                size: 150.0,
                                // color: symbolsColors,
                              ),
                              Text(
                                'Multiply',
                                style: TextStyle(
                                    fontSize: 30.0,
                                    // color: textColor,
                                    letterSpacing: 2.0),
                              )
                            ],
                          ),
                        ),
                        // color: cardColor,
                        // elevation: 10.0,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          elevation: 15.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: (){},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: InPage.cardVerticalLen,
                              horizontal: InPage.cardHorizontalLen),
                          child: Column(
                            children: [
                              Icon(
                                CupertinoIcons.divide,
                                size: 150.0,
                                // color: symbolsColors,
                              ),
                              Text(
                                'Division',
                                style: TextStyle(
                                    fontSize: 30.0,
                                    // color: textColor,
                                    letterSpacing: 2.0),
                              )
                            ],
                          ),
                        ),
                        // color: cardColor,
                        // elevation: 10.0,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellow,
                          elevation: 15.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          ),
        ),
        // backgroundColor: Colors.grey,
      ),
    );
  }
}
