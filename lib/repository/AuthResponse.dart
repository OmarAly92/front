// lib/repository/AuthResponse.dart
class AuthResponse {
  String token = "";
  String type = "";
  String email = "";

  AuthResponse({required this.token, required this.type, required this.email});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      type: json['type'],
      email: json['email'],
    );
  }
}
