import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// ignore_for_file: file_names, unused_field
/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetUserDataController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Object?>>> getUserData(String uId) async {
    final QuerySnapshot userData = await _firestore
        .collection('users')
        .where('uid', isEqualTo: uId)
        .get();

    //QuerySnapshot	Full query result	final snapshot = await query.get()
    // QueryDocumentSnapshot	One document from the result
    //Practice
  /*  for( QueryDocumentSnapshot doc in userData.docs )
      {
        print(doc.id); // Document ID
        print(doc['name']); // Field value
      }*/

    return userData.docs;
  }
}
*/
class GetUserDataController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getUserData(String uId) async {
    final QuerySnapshot userData = await _firestore
        .collection('users')
        .where('uid', isEqualTo: uId)
        .get();

    if (userData.docs.isNotEmpty) {
      return userData.docs.first.data() as Map<String, dynamic>;
    } else {
      throw Exception("User not found");
    }
  }


}
