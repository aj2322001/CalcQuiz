import 'dart:async';
import 'package:calc_quiz/blocs/auth_bloc.dart';
import 'package:calc_quiz/services/lev_sublev.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  StreamSubscription<User> loginStateSubscription;
  final databaseReference = FirebaseDatabase.instance.reference();
  int lev,sublev;
  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);

    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser != null) {
        databaseReference.once().then((DataSnapshot snapshot) {
          var indUid = fbUser.uid;
          Map<dynamic, dynamic> values = snapshot.value;
          values.forEach((key,values) {
            if(key==indUid){
              lev = values['level'];
              sublev = values['subLevel'];
              print('in: $lev, $sublev');
              Navigator.pushReplacementNamed(context, '/profile',arguments: LevSublev(cLevel: lev,cSublev: sublev));
            }
          });
        });
        // Navigator.pushReplacementNamed(context, '/profile');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);

    Widget googleLoginButton() {
      return ElevatedButton.icon(
        icon: Image.asset(
          'assets/google_logo.png',
          height: 35.0,
        ),
        label: Row(
          children: [
            Text(
              'Sign In with ',
              style: TextStyle(
                  color: Colors.amber, letterSpacing: 0.5, wordSpacing: 0.5),
            ),
            //fancy Google name in button
            Text(
              'G',
              style: TextStyle(color: Colors.blueAccent[100]),
            ),
            Text(
              'o',
              style: TextStyle(color: Colors.redAccent[100]),
            ),
            Text(
              'o',
              style: TextStyle(color: Colors.yellowAccent[100]),
            ),

            Text(
              'g',
              style: TextStyle(color: Colors.blueAccent[100]),
            ),
            Text(
              'l',
              style: TextStyle(color: Colors.greenAccent[100]),
            ),
            Text(
              'e',
              style: TextStyle(color: Colors.redAccent[100]),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 17.0),
          primary: Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          onSurface: Colors.grey,
          elevation: 10.0,
        ),
        onPressed: () => authBloc.loginGoogle(),
      );
    }

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, colors: [
            Colors.amber[900],
            Colors.amber[800],
            Colors.amber[700],
            Colors.amber[600],
            Colors.amber,
          ]),
        ),
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/icon_app.png',height: 75.0),
              Column(
                children: [
                  Text(
                    'Calc',
                    style: TextStyle(
                      fontSize: 175.0,
                      color: Colors.grey[850],
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Quiz',
                    style: TextStyle(
                      fontSize: 105.0,
                      fontWeight: FontWeight.w100,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
      floatingActionButton: DelayedDisplay(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 75),
          child: googleLoginButton(),
        ),
        delay: Duration(seconds: 3),
        // slidingCurve: Curves.bounceOut,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.amber,
      //   elevation: 0.0,
      //   child: Container(
      //     height: 40.0,
      //     child: AnimatedTextKit(
      //       animatedTexts: [
      //         TypewriterAnimatedText(
      //           'You Can Count on It',
      //         ),
      //       ],
      //       isRepeatingAnimation: false,
      //     ),
      //   ),
      // ),
    );
  }
}
