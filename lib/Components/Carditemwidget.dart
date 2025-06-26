import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/utils/AppTextFile.dart';

import '../Network/CartController.dart';
import '../models/cartModel.dart';

// Dummy AppTextStyles with a sample price style

// Dummy data model
class CartItemModel {
  final String storeName;
  final String productTitle;
  final String productDetails;
  final String imageUrl;
  final int quantity;
  final double price;

  CartItemModel({
    required this.storeName,
    required this.productTitle,
    required this.productDetails,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });
}

// Main screen widget
class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {




  //List<CartModel> _cartItems = [];


  CartController cartController = Get.put(CartController());
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, bool> selectedItems = {}; // productId -> isSelected


  Future<void> handleCartItem({required int index, required String productId}) async {
    final item = cartController.cartItems[index]; // get item
    final int quantity = item.productQuantity; // get quantity from item


    if (quantity > 1) {
      // Reduce quantity by 1
      final newQty = quantity - 1;
      final double unitPrice = item.productTotalPrice / quantity;

      final double newTotalPrice = unitPrice * newQty;
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(user!.uid)
          .collection('cartOrders')
          .doc(productId)
          .update({
        'productQuantity': newQty,
        'productTotalPrice': newTotalPrice.toInt(),
      });


      print("Updating productId: $productId for user: ${user!.uid}");


      cartController.getCurrentUserCart(); // Refresh cart

      // Do something with item or quantity
    }
    else {
      // Optional: Remove item if quantity is 1
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(user!.uid)
          .collection('cartOrders')
          .doc(productId)
          .delete();

      cartController.getCurrentUserCart(); // Refresh cart
    }
  }

  Future<void> increaseCartItem({required int index, required String productId}) async {
    final item = cartController.cartItems[index];
    final int currentQty = item.productQuantity;

    // Calculate unit price safely
    double unitPrice = 0;
    if (currentQty > 0) {
      unitPrice = item.productTotalPrice / currentQty;
    } else {
      // Fallback in case of bad data
      unitPrice = item.salePrice.toDouble();
    }

    final int newQty = currentQty + 1;
    final double newTotalPrice = unitPrice * newQty;

    await FirebaseFirestore.instance
        .collection('cart')
        .doc(user!.uid)
        .collection('cartOrders')
        .doc(productId)
        .update({
      'productQuantity': newQty,
      'productTotalPrice': newTotalPrice.toInt(), // store as int if you want
    });

    cartController.getCurrentUserCart(); // Refresh cart
  }


  Future<void> deleteCartItem({required String productId}) async {
    await FirebaseFirestore.instance
        .collection('cart')
        .doc(user!.uid)
        .collection('cartOrders')
        .doc(productId)
        .delete();
  }





  @override
  void initState() {
    super.initState();
    cartController.getCurrentUserCart(); // Optional but safe
  }




    @override
    Widget build(BuildContext context) {
      return Obx(() =>
          Scaffold(


            body: GridView.builder(

              padding: EdgeInsets.all(20),
              itemCount: cartController.cartItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 220, // height per item
              ),

              itemBuilder: (context, index) {
                final  item = cartController.cartItems[index];

                return Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      // Store Row
                      Row(
                        children: [
                          Checkbox(
                            value: selectedItems[item.productId] ?? false,
                            onChanged: (bool? value) async {
                              setState(() {
                                selectedItems[item.productId] = value ?? false;
                              });

                              if (value == true) {
                                await deleteCartItem(productId: item.productId);
                                cartController.getCurrentUserCart();
                                selectedItems.remove(item.productId); // Optional: cleanup
                              }
                            },
                          ),
                          Icon(Icons.store),
                          SizedBox(width: 4),
                          Text(item.categoryName, style: TextStyle(
                              fontWeight: FontWeight.bold)),


                        ],
                      ),
                      SizedBox(height: 6),

                      // Product Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: item.productImages[0],
                              // assuming it's the first image in the list
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),

                          SizedBox(width: 12),
                          // Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.productName, maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                                SizedBox(height: 4),
                                Text(item.productDescription, style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text("Rs. ${item.productTotalPrice
                                        .toStringAsFixed(0)}",
                                        style: AppTextStyles.priceStyle),
                                    Spacer(),
                                    // Quantity
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () {
                                              handleCartItem(index: index,productId: item.productId);
                                            },
                                            constraints: BoxConstraints(),
                                            padding: EdgeInsets.zero,
                                          ),
                                          Text("${item.productQuantity}"),
                                          IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              increaseCartItem(index: index,productId: item.productId);
                                            },
                                            constraints: BoxConstraints(),
                                            padding: EdgeInsets.zero,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),);
    }
  }


