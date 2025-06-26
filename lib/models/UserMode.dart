class UserModel {
  final String uid;
  final String username;
  final String password;
  final String deviceToken;
  final bool isAdmin; // optional with default

  final String? displayName;
  final String? email;
  final String? photoUrl;

  UserModel({
    required this.uid,
    required this.username,
    required this.password,
    required this.deviceToken,
    this.isAdmin = false, // ✅ default value
    this.displayName,
    this.email,
    this.photoUrl,
  });

  // Convert UserModel to a Map (for Firestore or local storage)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'password': password,
      'deviceToken': deviceToken,
      'isAdmin': isAdmin,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  // Create UserModel from a Firestore document/map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      deviceToken: map['deviceToken'] ?? '',
      isAdmin: map['isAdmin'] is bool ? map['isAdmin'] : false, // ✅ FIXED
      displayName: map['displayName'],
      email: map['email'],
      photoUrl: map['photoUrl'],

    );
  }
}
