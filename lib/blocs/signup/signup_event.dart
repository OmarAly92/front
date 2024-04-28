// lib/blocs/signup/signup_event.dart

import 'package:equatable/equatable.dart';

abstract class SignupEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class StartEvent extends SignupEvents {}

class RegisterButtonPressed extends SignupEvents {
  final String email;
  final String password;
  final String name;
  final String agencyName;
  final String type;
  final String language;
  final String country;
  final String location;
  final String description;

  RegisterButtonPressed({
    required this.email,
    required this.password,
    required this.name,
    required this.agencyName,
    required  this.type ,
    required this.language,
    required this.country,
    required this.location,
    required this.description,
  });

  @override
  List<Object> get props => [
        email,
        password,
        name,
        agencyName,
        type,
        language,
        country,
        location,
        description,
      ];
}
