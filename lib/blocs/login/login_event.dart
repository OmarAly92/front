// lib/blocs/login/login_event.dart

import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  // final String type; 


  const LoginButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password/* , type */];
}

class NavigateToLogin extends LoginEvent {
  // Specify the destination screen or route
  const NavigateToLogin();
}
