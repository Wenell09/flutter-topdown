class UserModel {
  final String userId, username, email, role, password, createdAt, image;
  final int saldo;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.role,
    required this.password,
    required this.saldo,
    required this.image,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: json["user_id"] ?? "",
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        role: json["role"] ?? "",
        password: json["password"] ?? "",
        saldo: json["saldo"] ?? 0,
        image: json["image"] ?? "",
        createdAt: json["created_at"] ?? "");
  }
}
