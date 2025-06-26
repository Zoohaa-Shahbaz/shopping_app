import 'package:flutter/material.dart';
import 'package:shopping_app/utils/appconstant.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: AppContant.primaryColor, // Customize color as needed
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Welcome, Admin!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
