class User {
  final String id;
  final String fullname;
  final String email;
  final String? password; // Nullable field
  final String? token; // Nullable field
  final String? createdAt;
  final int? version;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    this.password,
    this.token,
    this.createdAt,
    this.version,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullname: json['fullname'],
      email: json['email'],
      password: json['password'],
      token: json['token'],
      createdAt: json['createdAt'],
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullname': fullname,
      'email': email,
      'password': password,
      'token': token,
      'createdAt': createdAt,
      '__v': version,
    };
  }
}
