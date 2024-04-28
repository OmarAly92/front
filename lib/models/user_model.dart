// lib/models/user_model.dart

import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String password;
  final String type;
  final String country;
  final String language;
  final String token;
  // final List<dynamic> cart;

  const User( {
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    required this.country,
    required this.language,
    required this.token,
    // required this.cart,
  });

  @override
  List<Object?> get props => [id, password];
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'type': type,
      'country': country,
      'language' : language,
      'token': token,
      // 'cart': cart,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      type: map['type'] ?? '',
      country: map['country'] ?? '',
      language: map['language'] ?? '',
      token: map['token'] ?? '', 
      // cart: List<Map<String, dynamic>>.from(
      //   map['cart']?.map(
      //     (x) => Map<String, dynamic>.from(x),
      //   ),
      // ),
    );
  }

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
