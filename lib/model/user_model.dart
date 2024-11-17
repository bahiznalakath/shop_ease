class UserModel {
  final String uid;
  final String userType;
  final String name;
  final String email;

  UserModel({
    required this.uid,
    required this.userType,
    required this.name,
    required this.email,
  });

  // Factory method to create a UserModel from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      userType: map['user_type'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  // Convert UserModel to a map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'user_type': userType,
      'name': name,
      'email': email,
    };
  }
}
