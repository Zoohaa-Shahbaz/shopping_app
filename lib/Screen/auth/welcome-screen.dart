import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_app/Screen/auth/sign-in-screen.dart';
import 'package:shopping_app/utils/appconstant.dart';

import '../../utils/AppTextFile.dart';
import '../../Network/GoogleService.dart';
import '../User-panel/HomeScreen.dart';



class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  final GoogleService _googleService = GoogleService();

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppContant.primaryColor,
          title: Text('Welcome to my App',style: TextStyle(color: Colors.white),),
          centerTitle: true,

        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color:AppContant.primaryColor,


              ),

              child: Lottie.asset('assets/Shop.json'),



            ),

            SizedBox(height: 20,),
            Text("Happy Shopping ",style: AppTextStyles.boldBody,),

            SizedBox(height: 20,),
            Container(
                decoration: BoxDecoration(
                  color: AppContant.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),


                child: TextButton.icon(
                  icon: Icon(Icons.email, color: Colors.white), // icon color
                  onPressed: () {

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signin(),));
                  },
                  label: Text(
                    "Sign In with email",
                    style: TextStyle(color: Colors.white), // label text color
                  ),

                )),

            SizedBox(height: 20,),

            Container(
                decoration: BoxDecoration(
                  color: AppContant.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),


                child: TextButton.icon(
                  icon: Image.asset('assets/Google.png'), // icon color
                  onPressed: () async {
                    User? user = await _googleService.signInWithGoogle();

                    if (user != null) {
                      // Proceed to next step (e.g., navigate to Home Screen)
                      print('Signed in as: ${user.displayName}');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Homepage(user: user,)),
                      );
                    } else {
                      // Show error or retry
                      Fluttertoast.showToast(msg: "Google Sign-In failed");
                    }
                  },
                  label: Text(
                    "Sign In with Gmail",
                    style: TextStyle(color: Colors.white), // label text color
                  ),

                )),




            SizedBox(height: 20,),

            TextButton(
              onPressed: () {
                //    Navigator.push(context, MaterialPageRoute(builder: (context) => Main(),));
              },
              child: Text('Skip'),
            ),


            Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.grey,
            )

          ],
        ),
      ),
    );
  }
}
