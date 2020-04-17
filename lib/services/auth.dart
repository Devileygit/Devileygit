import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  //auth change user stream

  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  //register with email and pass

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and pass

  Future signInWithEmailIdAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      return null;
    }
  }

  //todo sign in with google

  Future signInWithGoogle() async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      AuthCredential _authCredential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      AuthResult result = await _auth.signInWithCredential(_authCredential);

      FirebaseUser user = result.user;

      return user;
    } catch (e) {
      return null;
    }
  }

  //todo sign in with fb
  // sign out With Email Pass
  Future signOut() async {
    try {
      return await _auth.signOut();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  //google sign out

  Future googleSignOut() async {
    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
      return await _auth.signOut();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }
}
