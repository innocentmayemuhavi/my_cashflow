import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_cashflow/models/user_model.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //user stream
  Stream<User_Class?> get user {
    return _auth
        .authStateChanges()
        .map((User? data) => _userFromFirebase(data));
  }

  //user object based on FirebaseUser
  User_Class? _userFromFirebase(User? data) {
    return data != null
        ? User_Class(
            uid: data.uid,
            displayName: data.displayName,
            email: data.email,
            photoUrl: data.photoURL,
            emailVerified: data.emailVerified)
        : null;
  }

  Future signInWithEmailAndPass(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = _auth.currentUser;
      return _userFromFirebase(user);
    } catch (e) {
      return e.toString();
    }
  }

  Future registerWithEmailAndPass(
      String email, String password, String displayName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await result.user!.updateDisplayName(displayName);

      // Send email verification
      // Send email verification
      result.user!.sendEmailVerification();

      return _userFromFirebase(result.user);
    } catch (e) {
      // print(e.toString());
      return e.toString();
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
