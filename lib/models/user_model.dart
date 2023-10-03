class UserModel {
  static String collectionName = 'users';

  String? id;
  String? email;
  String? name;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
  });

  factory UserModel.fromFirestore(Map<String, dynamic>? data) {
    return UserModel(
      id: data?['id'] as String?,
      email: data?['email'] as String?,
      name: data?['name'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }
}
