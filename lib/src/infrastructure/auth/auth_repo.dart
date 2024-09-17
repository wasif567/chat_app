import 'dart:developer';

import 'package:chat/src/domain/models/register_user/register_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> loginUser({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email.trim(), password: password.trim())
          .timeout(const Duration(minutes: 2));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    } catch (_) {
      rethrow;
    }
  }

  Future registerUser({required RegisterUserModel registerUser}) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: registerUser.email!.trim(),
        password: registerUser.password!.trim(),
      );

      // Save additional data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'id': userCredential.user!.uid,
        'displayName': registerUser.fullName!.trim(),
        'country': registerUser.country!.trim(),
        'mobile': registerUser.mobileNumber!.trim(),
      });
      if (userCredential.user != null) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (_) {
      rethrow;
    }
  }

  Future authCheck() async {
    try {
      final response = _auth.authStateChanges();
      log("${response.first}");
    } catch (e) {
      log("$e");
    }
  }

  Future logoutUser() async {
    try {
      await _auth.signOut();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      return user;
    } catch (_) {}
  }
}
