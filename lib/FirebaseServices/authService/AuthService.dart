import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } catch (e) {
      log("Error creating user: $e");
      return null;
    }
  }

  Future<String?> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Directly return the token after login
      return await credential.user?.getIdToken();
    } catch (e) {
      log("Error logging in user: $e");
      return null;
    }
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Error signing out: $e");
    }
  }

  Future<String?> getFirebaseToken() async {
    User? user = _auth.currentUser; // Get the current user directly
    if (user != null) {
      return await user.getIdToken();  // This will give the JWT token
    }
    return null;
  }
}
