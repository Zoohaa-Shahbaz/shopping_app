import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class GetDeviceTokenController extends GetxController {
  String? deviceToken;

  @override
  void onInit() {
    super.onInit();

    // Initialization logic here
    print("Controller initialized");

    getDeviceToken();

  }

  Future<void> getDeviceToken() async {
    try{
      String? token = await FirebaseMessaging.instance.getToken();
       if(token!=null)
         {
             deviceToken = token;
             update();
         }
    }
    catch(e)
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
