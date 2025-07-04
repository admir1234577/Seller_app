import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/const/firebase_consts.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  //textcontrollers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    }
    on FirebaseAuthException
    catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //singup


  //storing data method
  storeUserData({name, password, email}) async {
    DocumentReference store = await firestore.collection(vendorsCollection).doc(
        currentUser!.uid);
    store.set({'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': currentUser!.uid,
      'cart_count': "00",
      'order_count': "00",
      'wishlist_count': "00",

    });
  }

//signout
  signoutMethod(context) async {
    try {
      await auth.signOut();
    }
    catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
