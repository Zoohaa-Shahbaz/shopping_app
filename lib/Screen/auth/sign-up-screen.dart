import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/utils/appconstant.dart';

import '../../Controllers/SignUp_controller.dart';
import '../../Network/get-device-token.dart';
import '../User-panel/HomeScreen.dart';




class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  SignupController signupController = Get.put(SignupController());
  GetDeviceTokenController getDeviceTokenController = Get.put(GetDeviceTokenController());
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppContant.primaryColor,
          title: const Text(
            'Sign Up',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              // Email Field


              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: email,
                        validator: (value)
                        {
                          if(value==null || value.isEmpty)
                          {
                            return 'Please enter some text';
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),

                      SizedBox(height: 20,),

                      TextFormField(
                        controller: pass,
                        validator: (value)
                        {
                          if(value==null || value.isEmpty)
                          {
                            return 'Please enter some text';
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          labelText: 'Pass',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      )
                    ],


                  )),


              // Password Field

              const SizedBox(height: 30),


              Container(
                margin: EdgeInsets.symmetric(horizontal: 10) ,
                alignment: Alignment.centerRight,

                child: Text("Forgotten Password",style: TextStyle( fontWeight: FontWeight.bold,color: AppContant.primaryColor),),
              ),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(

                  onPressed: () async{
                    if(_formKey.currentState!.validate())
                    {

                      setState(() {
                        loading = true;
                      });
                      final deviceToken = getDeviceTokenController.deviceToken ?? '';
                      UserCredential? userCredential  = await signupController.signUpMethod( email.text.trim(),
                        pass.text.trim(),

                        deviceToken,).then((value) async {



                        setState(() {
                          loading = false;

                        });


                        if (UserCredential != null) {
                          User? user = value?.user; // ✅ This now works
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Homepage(user: user)),
                          );

                          Get.snackbar(
                            "Verification email sent.",
                            "Please check your email.",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppContant.primaryColor,
                            colorText: Colors.white,
                          );
                        }

                      },).onError((error, stackTrace) {
                        Fluttertoast.showToast(
                          msg: error.toString(),
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );

                      },);




                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppContant.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),


                ),

              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Sign Up screen
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppContant.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
