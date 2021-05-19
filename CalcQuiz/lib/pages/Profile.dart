import 'dart:async';
import 'dart:ui';
import 'package:calc_quiz/services/lev_sublev.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:calc_quiz/blocs/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:delayed_display/delayed_display.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int dataSubLev;
  final databaseReference = FirebaseDatabase.instance.reference();
  List<int> myList = [];
  int myVal = 0;
  static int level = 1;
  static int subLev = 1;
  StreamSubscription<User> loginStateSubscription;
  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if(fbUser == null){
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
    // super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    try {
      dataSubLev = ModalRoute
          .of(context)
          .settings
          .arguments;
      myVal = dataSubLev != null ? dataSubLev : 0;
      print('myVal = $myVal');
      subLev += myVal;
      print(subLev);
      if (subLev>5){
        level += 1;
        subLev = 1;
      };
    }catch(e){
      final args = ModalRoute.of(context).settings.arguments as LevSublev;
      level = args.cLevel;
      subLev = args.cSublev;
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: StreamBuilder<User>(
            stream: authBloc.currentUser,
            builder: (context, snapshot) {
              if(!snapshot.hasData) return CircularProgressIndicator();
              //updating values
              if (myVal==1){
                databaseReference.child('${snapshot.data.uid}').update({
                  'level': level,
                  'subLevel': subLev
                });
              }
              return ListView(
                children: [
                  IconButton(
                    icon: Image.asset('assets/log_out.png',scale: 20.0,),
                    alignment: Alignment.topLeft,
                    onPressed: () => authBloc.logout(),
                  ),
                  Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data.photoURL.replaceFirst('s96', 's500')),
                      backgroundColor: Colors.amber,
                      radius: 100,
                    ),
                  ),
                  Divider(
                    height: 60.0,
                    thickness: 2.0,
                    indent: 50.0,
                    endIndent: 50.0,
                  ),
                  Text(
                    'NAME',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 3.0,
                    ),
                  ),
                  Text(
                    snapshot.data.displayName,
                    style: TextStyle(
                      color: Colors.amber,
                      letterSpacing: 2.0,
                      fontSize: 36.0,
                    ),
                  ),
                  // SizedBox(
                  //   height: 30.0,
                  // ),
                  // Text(
                  //   'DATE OF BIRTH',
                  //   style: TextStyle(
                  //     color: Colors.grey,
                  //     letterSpacing: 3.0,
                  //   ),
                  // ),
                  // Text(
                  //   '1 Jan 2000',
                  //   style: TextStyle(
                  //     color: Colors.amber,
                  //     letterSpacing: 2.0,
                  //     fontSize: 36.0,
                  //   ),
                  // ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Level',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 3.0,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '$level',
                        style: TextStyle(
                          color: Colors.amber,
                          letterSpacing: 2.0,
                          fontSize: 45.0,
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
                  // SizedBox(
                  //   height: 40.0,
                  // ),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.phone,
                  //       color: Colors.greenAccent[400],
                  //     ),
                  //     SizedBox(
                  //       width: 10.0,
                  //     ),
                  //     Text(
                  //       '${snapshot.data.phoneNumber}',
                  //       style: TextStyle(
                  //         color: Colors.amber,
                  //         fontSize: 25.0,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 60.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.orange,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        snapshot.data.email,
                        style: TextStyle(
                          color: Colors.amber,
                          letterSpacing: 1.0,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ],
                // crossAxisAlignment: CrossAxisAlignment.start,
              );
            }
          ),
        ),
      ),
      floatingActionButton: DelayedDisplay(
        child: Container(
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, '/home',arguments: {'level':level,'subLev':subLev});
            },
            label: Text(
              'Start',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.grey[700],
              ),
            ),
            icon: Icon(
              CupertinoIcons.play_fill,
              color: Colors.grey[700],
            ),
            elevation: 10.0,
            backgroundColor: Colors.amber,
          ),
          padding: EdgeInsets.all(15),
          // color: Colors.white,
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
        ),
        delay: Duration(seconds: 1),
        slidingCurve: Curves.bounceOut,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: DelayedDisplay(
        child: BottomAppBar(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Colors.amber[700],
                Colors.amber[600],
                Colors.amber,
              ]),
            ),
          ),
          elevation: 10.0,
          // shape: CircularNotchedRectangle(),
          // color: Colors.amber[300],
        ),
        delay: Duration(milliseconds: 500),
      ),
    );
  }
}
