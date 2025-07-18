import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screen/User-panel/mycart.dart';
import 'Screen/auth/welcome-screen.dart';
import 'Components/Carditemwidget.dart';



void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Mainscreen(),
    );
  }
}
