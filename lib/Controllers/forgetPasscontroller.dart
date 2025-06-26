import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/models/UserMode.dart';

class Forgetpasscontroller {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _firestore = FirebaseStorage.instance;

  Future<UserCredential?> Resetpassword

      ( String email   )
  async {

    try{

      await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
          msg: "Request send succesfully Password resent link to ur email $email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    on FirebaseAuthException catch (e)
    {
      Fluttertoast.showToast(
          msg: "This is Center Short Toast",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }

  }



}