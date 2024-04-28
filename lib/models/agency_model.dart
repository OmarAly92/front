// lib/models/agency_model.dart

import 'dart:convert';

import 'package:equatable/equatable.dart';

class Agency extends Equatable {
  final String id;
  final String agencyName;
  final String email;
  final String password;
  final String type;
  final String location;
  final String description;
  final String token;
  // final List<dynamic> cart;

  const Agency( {
    required this.id,
    required this.agencyName,
    required this.email,
    required this.password,
    required this.type,
    required this.location,
    required this.description,
    required this.token,
    // required this.cart,
  });

  @override
  List<Object?> get props => [id, password];
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'agencyName': agencyName,
      'email': email,
      'password': password,
      'type': type,
      'location': location,
      'description' : description,
      'token': token,
      // 'cart': cart,
    };
  }

  factory Agency.fromMap(Map<String, dynamic> map) {
    return Agency(
      id: map['_id'] ?? '',
      agencyName: map['agencyName'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      type: map['type'] ?? '',
      location: map['location'] ?? '',
      description: map['description'] ?? '',
      token: map['token'] ?? '', 
      // cart: List<Map<String, dynamic>>.from(
      //   map['cart']?.map(
      //     (x) => Map<String, dynamic>.from(x),
      //   ),
      // ),
    );
  }

  factory Agency.fromJson(String source) => Agency.fromMap(json.decode(source));
}
