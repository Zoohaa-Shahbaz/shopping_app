import 'dart:core';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

import 'welcome-screen.dart';



class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});


  @override

  State<Splashscreen> createState() => _SplashscreenState();


}



class _SplashscreenState extends State<Splashscreen> {
  @override

  @override
  void initState() {
    // TODO: implement initState

    Timer(Duration(seconds: 3), ()
    {
      Navigator.push(context, MaterialPageRoute(builder:  (context) => Mainscreen(),));
    }
    );

    super.initState();
  }


  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Expanded(
              child: Container(
                child: Lottie.asset('assets/Shop.json'),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(bottom: 20.0), // Move 20 pixels up from bottom
              child: Text(
                "Develop by Abc",
                style: TextStyle(fontSize: 16),
              ),
            ),

          ],

        )

    );
  }
}
