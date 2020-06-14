import 'package:google_sign_in/google_sign_in.dart';
import 'package:ztiprojekt/abstracts/AppUser.dart';

class SignInEngine {
  SignInEngine() {
    _googleSignIn = GoogleSignIn(scopes: ['email']);
  }

  GoogleSignIn _googleSignIn;

  AppUser GetUser() {
    return AppUser(
      _googleSignIn.currentUser.displayName,
      _googleSignIn.currentUser.email,
      _googleSignIn.currentUser.photoUrl,
    );
  }

  login() async {
    await _googleSignIn.signIn();
  }

  logout() async {
    await _googleSignIn.signOut();
  }
}
