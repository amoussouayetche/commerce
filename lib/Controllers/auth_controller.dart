import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  //laoding
  var islaoding = false.obs;

  //text contrllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login methode
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signup method
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data method
  storeUserData({name, password, email, context}) async {
    try {
      // Votre code d'enregistrement ici
      DocumentReference store =
          firestore.collection(usersCollection).doc(currentUser!.uid);
      store.set({
        'name': name,
        'password': password,
        'email': email,
        'imageUrl': '',
        'id': currentUser!.uid,
        'cart_count': "00",
        'whishlist_count': "00",
        'order_count': "00",
      });
    } catch (error) {
      print("Erreur lors de l'enregistrement des données : $error");
    }
  }

  //signout method
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
