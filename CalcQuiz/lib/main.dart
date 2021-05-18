import 'package:calc_quiz/blocs/auth_bloc.dart';
import 'package:calc_quiz/pages/Profile.dart';
import 'package:calc_quiz/pages/homePage.dart';
import 'package:calc_quiz/pages/inPage.dart';
import 'package:calc_quiz/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        initialRoute: '/login',
        routes: {
          '/login': (context) => Login(),
          '/profile': (context) => Profile(),
          '/home': (context) => HomePage(),
          '/in_page': (context) => InPage(),
        },
      ),
    );
  }
}

