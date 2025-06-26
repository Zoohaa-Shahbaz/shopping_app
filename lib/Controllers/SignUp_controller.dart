import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_app/models/UserMode.dart';

import '../Network/get-device-token.dart';

class SignupController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //for password visibilty
  var isPasswordVisible = false.obs;
  Future<UserCredential?> signUpMethod(
      String userEmail,
      String userPassword,
      String userDeviceToken,
      ) async {
    EasyLoading.show(status: "Please wait");
    UserCredential userCredential =
    await _auth.createUserWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    );

    await userCredential.user!.sendEmailVerification();



    UserModel userModel = UserModel(uid: userCredential.user!.uid, displayName: userCredential.user!.displayName, email: userCredential!.user?.email, photoUrl: userCredential.user!.photoURL, username: '', password: '', deviceToken: userDeviceToken,isAdmin: false);

    _firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .set(userModel.toMap());
    EasyLoading.dismiss();
    return userCredential;


  }

}