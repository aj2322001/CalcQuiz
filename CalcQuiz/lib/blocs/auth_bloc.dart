import 'package:calc_quiz/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthBloc{
  final authService = AuthService();
  final googleSignIn = GoogleSignIn(scopes: ['email']);
  Stream<User> get currentUser => authService.currentUser;
  UserCredential resCopy;

  loginGoogle() async{
    try{
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken
      );
      //Firebase Sign in
      final result = await authService.signInWithCredential(credential);
      print('${result.user.displayName}');
      resCopy = result;
      final databaseReference = FirebaseDatabase.instance.reference();

      //create new database
      print('new user: ${result.additionalUserInfo.isNewUser}');
      if(result.additionalUserInfo.isNewUser) {
        databaseReference
            .child('${result.user.uid}')
            .set({'email': result.user.email, 'level': 1, 'subLevel': 1});
      }
      print('new database item Created');
    }catch(error){
      print(error);
    }
  }

  logout(){
    authService.logout();
  }
}