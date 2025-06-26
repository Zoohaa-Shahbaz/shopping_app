import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/cartModel.dart';

class CartController extends GetxController {
  var cartItems = <CartModel>[].obs;
  RxInt sum = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentUserCart();
  }

  void getCurrentUserCart() async {
    final user = FirebaseAuth.instance.currentUser;
    print("Called:");
    if (user == null) return;



    final snapshot = await FirebaseFirestore.instance
        .collection('cart')
        .doc(user.uid)
        .collection('cartOrders')
        .get();

    cartItems.value = snapshot.docs
        .map((doc) => CartModel.fromMap(doc.data()))
        .toList();

    sum.value = 0;
    for (final values in cartItems.value)
      {
        if(values!=null )
          {
            sum += values.productTotalPrice;
          }
      }


    print("Fetched cart items: ${cartItems.length}");
  }
}
