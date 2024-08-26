// user_model.dart
class User {
  final String id;
  final String username;
  final String password;
  final List<dynamic> wallets;
  final bool isAdmin;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String fname;
  final String lname;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.wallets,
    required this.isAdmin,
    required this.createdAt,
    required this.updatedAt,
    required this.fname,
    required this.lname,
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
      fname: json['fname'],
      lname: json['lname'],
    );
  }
}
