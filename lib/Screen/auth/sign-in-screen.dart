import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/Screen/auth/sign-up-screen.dart';
import 'package:shopping_app/utils/appconstant.dart';

import '../../Network/GetUserData.dart';
import '../../admin-panel/adminPanel.dart';
import '../User-panel/HomeScreen.dart';
import 'forgotten-password.dart';



class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();


}

class _SigninState extends State<Signin> {
  @override
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GetUserDataController getUserDataController = Get.put(GetUserDataController());
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppContant.primaryColor,
          title: const Text(
            'Welcome to my App',
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

                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),

                        validator: (onvalue)
                        {
                          if(onvalue==null || onvalue.isEmpty )
                          {
                            return "Please enter email";
                          }
                        },
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        controller: pass,
                        obscureText: true,
                        validator: (onvalue)
                        {
                          if(onvalue==null || onvalue.isEmpty )
                          {
                            return "Please enter Password";
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),



                    ],
                  )),



              // Password Field

              const SizedBox(height: 30),

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgottenPassword(),));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10) ,
                  alignment: Alignment.centerRight,

                  child: Text("Forgotten Password",style: TextStyle( fontWeight: FontWeight.bold,color: AppContant.primaryColor),),


                ),
              ),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  /*   onPressed: () {
                    if(_formKey.currentState!.validate())
                      {
                      final  UserCredential  =   auth.signInWithEmailAndPassword(email: email.text.toString(), password: pass.text.toString()).then((value) async {
                          User? user = value.user;

                          var UserData = await getUserDataController.getUserData(value.user!.uid);
                          if(value.user!.emailVerified)
                            {

                              //if(UserData[0]['isAdmin'] == true)
                              if (UserData['isAdmin'] == true)
                                {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => AdminPage()),
                                  );
                                }
                              else {
                                print("This condition is run True");
                                print("This condition is run True");
                                print("This condition is run True");
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => Main(user: user)),
                               );
                              }
                            }

                        //  Navigator.push(context, MaterialPageRoute(builder: (context) => Main(),));
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
                  },*/
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final UserCredential credential = await auth.signInWithEmailAndPassword(
                          email: email.text.trim(),
                          password: pass.text.trim(),
                        );

                        User? user = credential.user;

                        if (user == null) {
                          Fluttertoast.showToast(
                            msg: "Login failed: User is null.",
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                          return;
                        }

                        if (!user.emailVerified) {
                          Fluttertoast.showToast(
                            msg: "Please verify your email before signing in.",
                            backgroundColor: Colors.orange,
                            textColor: Colors.white,
                          );
                          return;
                        }

                        // ✅ Correctly await and use Map<String, dynamic>
                        final userData = await getUserDataController.getUserData(user.uid);

                        final isAdmin = userData['isAdmin'];

                        if (isAdmin == true) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => AdminPage()),
                          );
                        } else {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Homepage(user: user)),
                                (route) => false, // This removes all previous routes (e.g., login screen)
                          );

                        }
                      } catch (e, stackTrace) {
                        print("Login error: $e");
                        print("Stack trace: $stackTrace");

                        Fluttertoast.showToast(
                          msg: "Login failed: $e",
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                      }
                    }
                  }

                  ,style: ElevatedButton.styleFrom(
                  backgroundColor: AppContant.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                  child: const Text(
                    'Sign IN',
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
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
