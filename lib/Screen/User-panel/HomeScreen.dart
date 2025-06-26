import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_app/utils/appconstant.dart';

import '../../Widget/CategoryWidget.dart';
import '../../Widget/HeadingWidget.dart';
import '../../Widget/bannerWidget.dart';
import '../../Widget/FlashSale.dart';
import '../../Widget/mydrawer.dart';
import 'allproduct_screen.dart';
import '../auth/welcome-screen.dart';
import 'checkoutbottonSheet.dart';
import 'mycart.dart';


class Homepage extends StatefulWidget {
  final User? user;
  const Homepage({super.key, required this.user});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<Widget> _pages = [

    Mycart(),
    Homepage(user:null,),

  ];

  Future<void> _signOut() async {
    try {
      // Sign out from Firebase
      await _auth.signOut();

      // Also sign out from Google if used
      final googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }

      // Navigate to welcome screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Mainscreen()),
      );
    } catch (e) {
      print("Error signing out: $e");
      // Show a snackbar or toast if you want
    }
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppContant.primaryColor,
        title: const Text("Shopping App"),
        actions: [

          IconButton(
            icon: const Icon(Icons.add_chart),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>Mycart() ,));
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      drawer: MyDrawer(
        UserName: widget.user?.displayName ?? "No Name",
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            //  SizedBox(height: Get.height / 90),
            BannerWiget(),
            HeadingWidget(
              headingTitle: "Categories",
              headingSubTitle: "According to your budget",
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AllproductScreen()),
              ),
              buttonText: "See More >",
            ),
            CatagoryWidget(),

            HeadingWidget(
              headingTitle: "Flash Sales",
              headingSubTitle: "According to your budget",
              onTap: () => print("btn"),
              buttonText: "See More >",
            ),

           FlashSale(),




            // Add your widgets here
          ],
        ),
      ),
    );
  }
}
