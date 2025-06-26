import 'package:firebase_messaging/firebase_messaging.dart';

class CustomerToken
{
Future<String> getCustomerDeviceToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  if (token != null) {
    return token;
  } else {
    // Return an empty string or throw an error based on your app's need
    return '';
    // or throw Exception('Device token not available');
  }
}
}

