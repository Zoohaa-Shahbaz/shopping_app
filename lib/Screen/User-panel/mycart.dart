import 'package:flutter/material.dart';
import 'package:shopping_app/Widget/custombtnbar.dart';
import 'package:shopping_app/utils/AppTextFile.dart';

import '../../Components/Carditemwidget.dart';
import '../../Widget/CartCheckoutBar.dart';
import '../../Widget/button.dart';
class Mycart extends StatelessWidget {
  const Mycart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart", style: AppTextStyles.body),
        actions: [Icon(Icons.delete)],
      ),
      body: Stack(
        children: [
          // Scrollable content with padding at the bottom
          CartScreen(),
          // Fixed Checkout Bar at Bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CartCheckoutBar(),
          ),
        ],
      ),
    );
  }
}
