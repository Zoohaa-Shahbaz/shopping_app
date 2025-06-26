import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class bannerController extends GetxController{

  RxList<String> bannerUrls = RxList<String>([]);

  @override
  void onInit()
  {
    super.onInit();
    fetchCollectionData();
  }

  Future<void> fetchCollectionData() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('banners')
          .get();

      if (snapshot.docs.isNotEmpty) {
        bannerUrls.value = snapshot.docs
            .map((doc) => doc['imgUrl'] as String)
            .toList();

        // Do something with dataList
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}
