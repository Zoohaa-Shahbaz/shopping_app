import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/models/productmodel.dart';

import 'Category.dart';

class getCatagory{
  final List<Category> _categories = [];
  final List<ProductModel> _ProductModel = [];
  Future<List<Category>> fetchCategories() async {
    _categories.clear(); // ✅ Clear previous data

    final snapshot = await FirebaseFirestore.instance
        .collection('catagories')
        .get();




    for(var items in snapshot.docs)
    {
      final data = items.data();
      final category = Category.fromMap(data);

      _categories.add(category);
    }
   // final data = snapshot.docs.map((doc) => Category.fromMap(doc.data())).toList();


    return _categories;

  }

  Future<List<ProductModel>> getProducts() async {
    _ProductModel.clear(); // ✅ Clear previous data

    final snapshot = await FirebaseFirestore.instance
        .collection('products').where('isSale',isEqualTo: true)
        .get();




    for(var items in snapshot.docs)
    {
      final data = items.data();
      final products = ProductModel.fromMap(data);

      _ProductModel.add(products);
    }
    // final data = snapshot.docs.map((doc) => Category.fromMap(doc.data())).toList();


    return _ProductModel;

  }
}