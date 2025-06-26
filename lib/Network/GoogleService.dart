import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_app/models/UserMode.dart';

import 'get-device-token.dart';

class GoogleService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final GetDeviceTokenController getDeviceTokenController = Get.put(GetDeviceTokenController());

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      // 1. Trigger Google Sign-In popup
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();


      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      if(googleUser!=null)
        {
          EasyLoading.show(status: "Please Wait");

          // 2. Get Google Sign-In authentication details

          final GoogleSignInAuthentication googleAuth = await googleUser.authentication;


          // 3. Create a new credential for Firebase
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          // 4. Sign in to Firebase with that credential
          final UserCredential userCredential = await _auth.signInWithCredential(credential);

          final User? user = userCredential.user;

          if(user!=null)
          {
            UserModel userModel = UserModel(uid: user.uid, displayName: user.displayName, email: user.email, photoUrl: user.photoURL, username: '', password: '', deviceToken: getDeviceTokenController.deviceToken.toString(),isAdmin: false);
            await FirebaseFirestore.instance.collection('users').doc(user.uid).set(userModel.toMap());
            EasyLoading.dismiss();
          }

          return userCredential.user;
        }
    return null;

    } catch (e) {
      EasyLoading.dismiss();

      print('Google Sign-In Error: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
