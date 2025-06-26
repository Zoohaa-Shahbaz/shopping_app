import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/models/productmodel.dart';
import '../Controllers/bannerController.dart';
import '../Screen/User-panel/reviewPro_details_screen.dart';
import '../models/Category.dart';
import '../models/getCatagory.dart';

class FlashSale extends StatefulWidget {
  @override
  State<FlashSale> createState() => _FlashSaleState();
}

class _FlashSaleState extends State<FlashSale> {
  final bannerController _bannerController = Get.put(bannerController());
  final getCatagory _fetchCategories = Get.put(getCatagory());
  Future<RxList<String>> fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    return _bannerController.bannerUrls;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder <List<ProductModel>>(
      future: _fetchCategories.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final products = snapshot.data!;

          // Example labels (optional: replace with dynamic ones)

          return SizedBox(
            height: Get.height / 10 + 80, // space for image + text
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: Get.width / 3,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),

                        child: GestureDetector(
                          onTap: (){
                            navigator?.push(MaterialPageRoute(builder: (context) => productDetails(product: products[index],),));
                          },
                          child: CachedNetworkImage(
                            imageUrl: products[index].productImages.first,
                            height: Get.height / 10,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        products[index].categoryName.toString(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Rs ${products[index].fullPrice.toString()}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('No data found'),
          );
        }
      },
    );
  }
}
