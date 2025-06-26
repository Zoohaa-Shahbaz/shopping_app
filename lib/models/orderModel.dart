class OrderModel {
  final String productId;
  final String customerName;
  final String customerPhone;
  final String address;
  final String deviceToken;

  OrderModel({
    required this.productId,
    required this.customerName,
    required this.customerPhone,
    required this.address,
    required this.deviceToken,
  });

  // Convert OrderModel to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'address': address,
      'deviceToken': deviceToken,
    };
  }

  // Create OrderModel from Firebase Document
  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      productId: map['productId'] ?? '',
      customerName: map['customerName'] ?? '',
      customerPhone: map['customerPhone'] ?? '',
      address: map['address'] ?? '',
      deviceToken: map['deviceToken'] ?? '',
    );


  }
}
