
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/models/orderModel.dart';

import '../Network/CartController.dart';
import 'dart:math';


class OrderService{

  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String customerDeviceToken;

  OrderService({
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerDeviceToken,
  });



  CartController cartController = Get.put(CartController());
  //var cartItems = <CartItemModel>[].obs;

  User? user = FirebaseAuth.instance.currentUser;



  void placeOrder () async
  {


    cartController.getCurrentUserCart(); // Optional but safe

    for(var data in cartController.cartItems){

      OrderModel _moder = OrderModel(productId:data.productId, customerName: customerName ?? '', customerPhone: customerPhone, address: customerAddress, deviceToken: customerDeviceToken);



      await FirebaseFirestore.instance.collection('orders').doc(user?.uid).set(
        {
          'uId': user?.uid,
          'customerName': customerName,
          'customerPhone': customerPhone,
          'customerAddress': customerAddress,
          'customerDeviceToken': customerDeviceToken,
          'orderStatus': false,
          'createdAt': DateTime.now()
        },
      );


      
      await FirebaseFirestore.instance.collection('cart').doc(user?.uid).collection('cartOrders').doc(_moder.productId.toString()).delete().then((value) => print("Product deleted"),);
    }

    print("Order place");


  }
  String generateRandomCodeId({int length = 10}) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random();

    return List.generate(length, (index) => chars[rand.nextInt(chars.length)]).join();
  }
}




