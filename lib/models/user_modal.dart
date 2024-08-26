// user_model.dart
class User {
  final String id;
  final String username;
  final String password;
  final List<dynamic> wallets;
  final bool isAdmin;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? fname;  // Make these fields nullable
  final String? lname;
  final String? email;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.wallets,
    required this.isAdmin,
    required this.createdAt,
    required this.updatedAt,
    this.fname,
    this.lname,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      password: json['password'],
      wallets: json['wallets'],
      isAdmin: json['isAdmin'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      fname: json['fname'],  // These fields are now optional
      lname: json['lname'],
      email: json['email'],
    );
  }
}
