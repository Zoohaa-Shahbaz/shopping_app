import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/bannerController.dart';
import '../models/Category.dart';
import '../models/getCatagory.dart';

class CatagoryWidget extends StatefulWidget {
  @override
  State<CatagoryWidget> createState() => _CatagoryWidgetState();
}

class _CatagoryWidgetState extends State<CatagoryWidget> {
  final bannerController _bannerController = Get.put(bannerController());
  final getCatagory _fetchCategories = Get.put(getCatagory());
  Future<RxList<String>> fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    return _bannerController.bannerUrls;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder <List<Category>>(
      future: _fetchCategories.fetchCategories(),
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
          final imageUrls = snapshot.data!;

          // Example labels (optional: replace with dynamic ones)
          final labels = ['Shoes', 'Shirts', 'Watches', 'Bags', 'Hats'];

          return SizedBox(
            height: Get.height / 10 + 40, // space for image + text
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                final label = labels.length > index ? labels[index] : 'Item ${index + 1}';

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: Get.width / 4.5,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),

                        child: CachedNetworkImage(
                          imageUrl: imageUrls[index].categoryImg,
                          height: Get.height / 12,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        imageUrls[index].categoryName.toString(),
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
