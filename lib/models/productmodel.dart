import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final List<String> productImages;
  final String categoryId;
  final String categoryName;
  final DateTime createdAt;
  final String deliveryTime;
  final int fullPrice;
  final bool isSale;
  final String productDes;
  final int salePrice;
  final String productId;
  


  ProductModel( {
    required this.productImages,
    required this.categoryId,
    required this.categoryName,
    required this.createdAt,
    required this.deliveryTime,
    required this.fullPrice,
    required this.isSale,
    required this.productDes,
    required this.salePrice,
    required this.productId,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productImages: List<String>.from(map['ProductImages'] ?? []),
      categoryId: map['categoryId'] ?? '',
      categoryName: map['categoryName'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      deliveryTime: map['deliveryTime'] ?? '',
      fullPrice: map['fullPrice'] ?? 0,
      isSale: map['isSale'] ?? false,
      productDes: map['productDes'] ?? '',
      salePrice: map['salePrice'] ?? 0,
        productId : map['productId'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ProductImages': productImages,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'createdAt': createdAt,
      'deliveryTime': deliveryTime,
      'fullPrice': fullPrice,
      'isSale': isSale,
      'productDes': productDes,
      'productId' : productId,

    };
  }
}
