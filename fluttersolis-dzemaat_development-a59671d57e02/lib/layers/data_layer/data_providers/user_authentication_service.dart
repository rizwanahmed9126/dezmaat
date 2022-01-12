import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class UserAuthenticationService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount googleSignInAccount;
  FacebookLogin facebookLogin = FacebookLogin();
  var facebookAccount, appleAccount;
  User firebaseUser;

  // sign in anonymous
  Future<User> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      firebaseUser = userCredential.user;
      return firebaseUser;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign in with email and password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser = userCredential.user;
      if(firebaseUser.emailVerified)
        return firebaseUser;
      else{
        firebaseUser.sendEmailVerification();
        return null;
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future<User> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser = userCredential.user;
      firebaseUser.sendEmailVerification();
      return firebaseUser;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //Reset password
  Future<bool> resetPasswordRequest (String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    }
    catch (error) {
      print (error.message);
      return false;
    }
  }

  //Google Login
  Future<User> loginWithGoogle() async {
    try {
      googleSignInAccount = await googleSignIn.signIn();

      if(googleSignInAccount == null)
        return null;

      UserCredential userCredential = await _auth.signInWithCredential(GoogleAuthProvider.credential(
        idToken: (await googleSignInAccount.authentication).idToken,
        accessToken: (await googleSignInAccount.authentication).accessToken,
      ));
      firebaseUser = userCredential.user;

      if(firebaseUser == null)
        return null;

      return firebaseUser;
    } catch (error) {
      print(error.message);
      return null;
    }
  }

  //Facebook Login
  Future<User> loginWithFacebook () async {
    try{
      FacebookLoginResult facebookLoginResult = await facebookLogin.logIn(['email', 'public_profile']);
      switch (facebookLoginResult.status) {

        case FacebookLoginStatus.loggedIn:
          final token = facebookLoginResult.accessToken.token;
          http.Response facebookLoginResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
          final profile = JSON.jsonDecode(facebookLoginResponse.body);
          facebookAccount = profile;
          UserCredential userCredential = await _auth.signInWithCredential(FacebookAuthProvider.credential(facebookLoginResult.accessToken.token));
          firebaseUser = userCredential.user;
          return firebaseUser;
          break;

        case FacebookLoginStatus.cancelledByUser:
          return null;
          break;

        case FacebookLoginStatus.error:
          return null;
          break;

        default:
          return null;
          break;
      }
    }catch(error){
      print(error.message);
      return null;
    }

  }

  //Apple Login
  Future<User> loginWithApple() async {
    try{
      final result = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      appleAccount = result;
      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: result.identityToken,
        accessToken: result.authorizationCode,
      );
      final authResult = await _auth.signInWithCredential(credential);
      firebaseUser = authResult.user;
      return firebaseUser;
    }catch(error){
      print(error.message);
      return null;
    }
  }

  //Sign out firebase
  Future<bool> signOut() async {
    facebookAccount = null;
    googleSignInAccount = null;
    appleAccount = null;
    try {
       await _auth.signOut();
       return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

}

UserAuthenticationService userAuthenticationService = UserAuthenticationService();