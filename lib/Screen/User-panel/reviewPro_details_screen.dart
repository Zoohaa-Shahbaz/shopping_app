import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/Controllers/bannerController.dart';
import 'package:shopping_app/models/cartModel.dart';
import 'package:shopping_app/models/productmodel.dart';
import 'package:shopping_app/utils/AppTextFile.dart';

import '../../Widget/bannerWidget.dart';
import '../../Widget/button.dart';
import '../../Widget/custombtnbar.dart';

class productDetails extends StatefulWidget {
  final ProductModel product;
  productDetails({super.key, required this.product});

  @override
  State<productDetails> createState() => _productDetailsState();
}

class _productDetailsState extends State<productDetails> {
  @override
  final CarouselController carouselController = CarouselController();

  final bannerController _bannerContoller = Get.put(bannerController());

  User? user  = FirebaseAuth.instance.currentUser;
  RxInt quantity = 1.obs;


  void _openCard() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Important for full height

      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image Preview
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: widget.product.productImages.first,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.salePrice != null && widget.product.salePrice > 0
                                    ? widget.product.salePrice.toString()
                                    : widget.product.fullPrice.toString(),
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),

                              Text(
                                "Options",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[800]),
                              ),
                            ],
                          ),
                        ]),
                    Divider(),
                    Text(
                      "Product",
                      style: AppTextStyles.body,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.product.productImages.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) {
                        //  final variant = product.variants[index];
                        return Container(
                          width: 200,
                          height: 150,
                          decoration: BoxDecoration(color: Colors.red),
                          child: CachedNetworkImage(
                            imageUrl: widget.product.productImages[index],

                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Quantity",
                          style: AppTextStyles.boldBody,
                        ),
                        Spacer(),
                        IconButton(onPressed: () {

                          updateQuantity(quantity.value - 1);
                        }, icon: Icon(Icons.remove)),

                        Obx(() => Text(quantity.value.toString())),

                        IconButton(onPressed: () {
                          updateQuantity(quantity.value + 1);
                        }, icon: Icon(Icons.add)),
                      ],
                    ),
                    CustomButton(
                      text: 'Add to Cart',
                      color: Colors.orange,
                      width: double.infinity,
                      onPressed: () {
                        isProductExits();
                        // checkProductExitence(uID:user!.uid);
                      },
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }


  Future<void> isProductExits() async {
    final doc = FirebaseFirestore.instance
        .collection('cart')
        .doc(user?.uid)
        .collection('cartOrders')
        .doc(widget.product.productId.toString());

    final snapshot = await doc.get();
    int selectedQty = quantity.value;

    if (snapshot.exists) {
      int existingQty = snapshot['productQuantity'] ?? 0;  //
     // int currentQty = quantity.value;
      int updateQty = existingQty + quantity.value;
      int totalPrice = widget.product.fullPrice * updateQty;

      await doc.update({
        'productQuantity': updateQty,
        'productTotalPrice': totalPrice,
      });
    } else {
      // Ensure parent doc exists
      await FirebaseFirestore.instance.collection('cart').doc(user?.uid).set({
        'uid': user?.uid,
        'createdAt': DateTime.now(),
      });

      // Define quantity and total price
      int productQuantity = selectedQty;
      int productTotalPrice = (widget.product.isSale
          ? widget.product.salePrice ?? widget.product.fullPrice
          : widget.product.fullPrice) *
          productQuantity;

      // Create CartModel
      CartModel _cartModel = CartModel(
        productId: widget.product.productId,
        categoryId: widget.product.categoryId,
        productName: widget.product.categoryName, // Replace with actual name
        categoryName: widget.product.categoryName,
        salePrice: widget.product.salePrice ?? 0,
        fullPrice: widget.product.fullPrice,
        productImages: widget.product.productImages,
        deliveryTime: widget.product.deliveryTime,
        isSale: widget.product.isSale,
        productDescription: widget.product.productDes,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        productQuantity: productQuantity,
        productTotalPrice: productTotalPrice,
      );

      // Save to Firestore
      await doc.set(_cartModel.toMap()); // Ensure toMap() method is defined in CartModel

      print("Date added :");
    }
  }

  void updateQuantity(int newQuantity) {
    if (newQuantity >= 1) {
      quantity.value = newQuantity;
    }
  }


  Widget build(BuildContext context) {
    final List<String> currentProduct = widget.product.productImages;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                text: 'Buy Now',
                color: Colors.orange,
                onPressed: () {
                  _openCard();
                },
              ),
              CustomButton(
                text: 'Add to Cart',
                color: Colors.red,
                onPressed: () {
                  _openCard();
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height / 70,
                ),
                Container(
                    child: CarouselSlider(
                        items: currentProduct
                            .map((element) => Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: CachedNetworkImage(
                                      imageUrl: element,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                          scrollDirection: Axis.horizontal,
                          autoPlay: false,
                          height: Get.height / 3.2,
                          viewportFraction:
                              1.0, // <- shows only one full image per page
          
                          enlargeCenterPage: false,
                        ))),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Rs. ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.orange[800],
                      ),
                    ),
                    Text(
                      widget.product.fullPrice.toString(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[800],
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      widget.product.salePrice.toString() ?? "0",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: 4),
                    /*   Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF1EC),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '-58%',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )*/
                  ],
                ),
                SizedBox(height: 6),
                // Title
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(widget.product.productDes,
                      style: AppTextStyles.boldBody),
                ),
                SizedBox(height: 6),
                // Ratings & Icons
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 18),
                    SizedBox(width: 4),
                    Text(
                      '5 (123) in Future',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(width: 8),
                    Text('|', style: TextStyle(color: Colors.grey)),
                    SizedBox(width: 8),
                    Text(
                      '605 sold',
                      style: TextStyle(fontSize: 14),
                    ),
                    Spacer(),
                    Icon(Icons.favorite_border),
                    SizedBox(width: 8),
                    Icon(Icons.share_outlined),
                  ],
                ),
          
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
