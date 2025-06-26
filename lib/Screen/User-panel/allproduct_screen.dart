import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/getCatagory.dart';

class AllproductScreen extends StatelessWidget {
  const AllproductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getCatagory _getCatagory = Get.put(getCatagory());

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: _getCatagory.fetchCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
      
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
      
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No products found'));
            }
      
            final addProducts = snapshot.data!;
      
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of columns
                crossAxisSpacing: 3.0,
                mainAxisSpacing: 3.0,
                childAspectRatio: 3 / 2.5, // width / height ratio
              ),
              itemCount: addProducts.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: Get.width / 2.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: addProducts[index].categoryImg,
                          height: Get.height / 10,
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
                        addProducts[index].categoryName.toString(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
      
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
